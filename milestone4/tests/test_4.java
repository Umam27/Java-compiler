public class test_4 {
    public static int factorial(int n) {
        int ans;
        if (n == 0) {
            return 1;
        } else {
            ans = n*factorial(n-1);
            return ans;
        }
        // return 120;
    }

    public static void main() {
        int n = 9;
        System.out.println(n);
        n = factorial(n); 
        System.out.println(n);
    }
}

