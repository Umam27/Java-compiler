public class test_5 {
    public static void fibonacci(int n) {
        int first = 0, second = 1, next;
        for (int i = 1; i <= n; i++) {
            System.out.print(first + " ");
            next = first + second;
            first = second;
            second = next;
        }
    }

    public static void main(String[] args) {
        int n = 10;
        System.out.println("Fibonacci series up to " + n + ":");
        fibonacci(n);
    }
}
