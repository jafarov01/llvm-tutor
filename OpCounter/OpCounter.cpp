#include "llvm/IR/IRBuilder.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

namespace {

struct OpCounter : public PassInfoMixin<OpCounter> {
  PreservedAnalyses run(Function &F, FunctionAnalysisManager &AM) {
    // First, I need to get the module and context to work with.
    Module *M = F.getParent();
    LLVMContext &Ctx = M->getContext();

    // Now, I declare the function that's in my Runtime.cpp file.
    // The function is called "op_counter" and takes a C-style string (char*).
    FunctionType *CounterFuncTy = FunctionType::get(Type::getVoidTy(Ctx), {PointerType::getUnqual(Type::getInt8Ty(Ctx))}, false);
    FunctionCallee CounterFunc = M->getOrInsertFunction("op_counter", CounterFuncTy);

    // Here is the main part: I loop through every instruction in the function.
    for (auto &BB : F) {
      for (auto &I : BB) {
        // For every instruction I find, I will inject a call to my op_counter function.
        // This IRBuilder helps me insert new code. I'm placing it right before the current instruction.
        IRBuilder<> Builder(&I);
        
        // I need to pass the name of the instruction (like "add" or "load") to my function.
        // I get the name and create a global string for it.
        Value *OpcodeName = Builder.CreateGlobalStringPtr(I.getOpcodeName());

        // And here I create the actual call to my op_counter function.
        Builder.CreateCall(CounterFunc, {OpcodeName});
      }
    }
    
    return PreservedAnalyses::all();
  }

  static bool isRequired() { return true; }
};

} // end anonymous namespace

// This is the standard boilerplate code to register my pass with LLVM so 'opt' can find it.
extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "OpCounter", "v0.1",
          [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, FunctionPassManager &FPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "op-counter") {
                    FPM.addPass(OpCounter());
                    return true;
                  }
                  return false;
                });
          }};
}
