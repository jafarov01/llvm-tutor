; ModuleID = 'test.ll'
source_filename = "test.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@0 = private unnamed_addr constant [7 x i8] c"alloca\00", align 1
@1 = private unnamed_addr constant [7 x i8] c"alloca\00", align 1
@2 = private unnamed_addr constant [6 x i8] c"store\00", align 1
@3 = private unnamed_addr constant [6 x i8] c"store\00", align 1
@4 = private unnamed_addr constant [5 x i8] c"load\00", align 1
@5 = private unnamed_addr constant [5 x i8] c"load\00", align 1
@6 = private unnamed_addr constant [4 x i8] c"mul\00", align 1
@7 = private unnamed_addr constant [4 x i8] c"ret\00", align 1
@8 = private unnamed_addr constant [7 x i8] c"alloca\00", align 1
@9 = private unnamed_addr constant [7 x i8] c"alloca\00", align 1
@10 = private unnamed_addr constant [7 x i8] c"alloca\00", align 1
@11 = private unnamed_addr constant [6 x i8] c"store\00", align 1
@12 = private unnamed_addr constant [6 x i8] c"store\00", align 1
@13 = private unnamed_addr constant [6 x i8] c"store\00", align 1
@14 = private unnamed_addr constant [3 x i8] c"br\00", align 1
@15 = private unnamed_addr constant [5 x i8] c"load\00", align 1
@16 = private unnamed_addr constant [5 x i8] c"icmp\00", align 1
@17 = private unnamed_addr constant [3 x i8] c"br\00", align 1
@18 = private unnamed_addr constant [5 x i8] c"load\00", align 1
@19 = private unnamed_addr constant [5 x i8] c"load\00", align 1
@20 = private unnamed_addr constant [4 x i8] c"sub\00", align 1
@21 = private unnamed_addr constant [5 x i8] c"call\00", align 1
@22 = private unnamed_addr constant [5 x i8] c"load\00", align 1
@23 = private unnamed_addr constant [4 x i8] c"add\00", align 1
@24 = private unnamed_addr constant [6 x i8] c"store\00", align 1
@25 = private unnamed_addr constant [3 x i8] c"br\00", align 1
@26 = private unnamed_addr constant [5 x i8] c"load\00", align 1
@27 = private unnamed_addr constant [4 x i8] c"add\00", align 1
@28 = private unnamed_addr constant [6 x i8] c"store\00", align 1
@29 = private unnamed_addr constant [3 x i8] c"br\00", align 1
@30 = private unnamed_addr constant [5 x i8] c"load\00", align 1
@31 = private unnamed_addr constant [4 x i8] c"ret\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @multiply(i32 noundef %0, i32 noundef %1) #0 {
  call void @op_counter(ptr @0)
  %3 = alloca i32, align 4
  call void @op_counter(ptr @1)
  %4 = alloca i32, align 4
  call void @op_counter(ptr @2)
  store i32 %0, ptr %3, align 4
  call void @op_counter(ptr @3)
  store i32 %1, ptr %4, align 4
  call void @op_counter(ptr @4)
  %5 = load i32, ptr %3, align 4
  call void @op_counter(ptr @5)
  %6 = load i32, ptr %4, align 4
  call void @op_counter(ptr @6)
  %7 = mul nsw i32 %5, %6
  call void @op_counter(ptr @7)
  ret i32 %7
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @main() #0 {
  call void @op_counter(ptr @8)
  %1 = alloca i32, align 4
  call void @op_counter(ptr @9)
  %2 = alloca i32, align 4
  call void @op_counter(ptr @10)
  %3 = alloca i32, align 4
  call void @op_counter(ptr @11)
  store i32 0, ptr %1, align 4
  call void @op_counter(ptr @12)
  store i32 0, ptr %2, align 4
  call void @op_counter(ptr @13)
  store i32 0, ptr %3, align 4
  call void @op_counter(ptr @14)
  br label %4

4:                                                ; preds = %14, %0
  call void @op_counter(ptr @15)
  %5 = load i32, ptr %3, align 4
  call void @op_counter(ptr @16)
  %6 = icmp slt i32 %5, 10
  call void @op_counter(ptr @17)
  br i1 %6, label %7, label %17

7:                                                ; preds = %4
  call void @op_counter(ptr @18)
  %8 = load i32, ptr %3, align 4
  call void @op_counter(ptr @19)
  %9 = load i32, ptr %3, align 4
  call void @op_counter(ptr @20)
  %10 = sub nsw i32 %9, 1
  call void @op_counter(ptr @21)
  %11 = call i32 @multiply(i32 noundef %8, i32 noundef %10)
  call void @op_counter(ptr @22)
  %12 = load i32, ptr %2, align 4
  call void @op_counter(ptr @23)
  %13 = add nsw i32 %12, %11
  call void @op_counter(ptr @24)
  store i32 %13, ptr %2, align 4
  call void @op_counter(ptr @25)
  br label %14

14:                                               ; preds = %7
  call void @op_counter(ptr @26)
  %15 = load i32, ptr %3, align 4
  call void @op_counter(ptr @27)
  %16 = add nsw i32 %15, 1
  call void @op_counter(ptr @28)
  store i32 %16, ptr %3, align 4
  call void @op_counter(ptr @29)
  br label %4, !llvm.loop !6

17:                                               ; preds = %4
  call void @op_counter(ptr @30)
  %18 = load i32, ptr %2, align 4
  call void @op_counter(ptr @31)
  ret i32 %18
}

declare void @op_counter(ptr)

attributes #0 = { noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 15, i32 5]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Homebrew clang version 20.1.7"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
