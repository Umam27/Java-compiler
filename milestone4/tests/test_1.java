public class test_1 {
    public static void main() {
        int a = 5;
        int b = 5;

        // Arithmetic operators
        int sum = a + b;
        System.out.println(sum);
        int diff = a - b;
        System.out.println(diff);
        int product = a * b;
        System.out.println(product);
        ++a;
        System.out.println(a);
        b--;
        System.out.println(b);
        int pi = a++;
        System.out.println(pi);
        System.out.println(a);
        int pd = b--;
        System.out.println(pd);
        System.out.println(b);

        // Assignment operators
        a += 2;
        b -= 2;
        a *= b;

        // Relational operators
        if(a==0) {
            System.out.println(1);
        }
        else {
            System.out.println(0);
        }
        if(a!=0) {
            System.out.println(1);
        }
        else {
            System.out.println(0);
        }
        if(a > 0) {
            System.out.println(1);
        }
        else {
            System.out.println(0);
        }
        if(a < 0) {
            System.out.println(1);
        }
        else {
            System.out.println(0);
        }
        if(a>=0) {
            System.out.println(1);
        }
        else {
            System.out.println(0);
        }
        if(a<=0) {
            System.out.println(1);
        }
        else {
            System.out.println(0);
        }
    }
}
