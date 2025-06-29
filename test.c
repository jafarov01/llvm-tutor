int multiply(int a, int b) {
    return a * b;
}
int main() {
    int result = 0;
    for (int i = 0; i < 10; i++) {
        result += multiply(i, i - 1);
    }
    return result;
}
