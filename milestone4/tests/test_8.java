public class Node {
    int data;
    int value;
}

public class test_8 {
    public static void main() {
        Node n = new Node();
        n.data = 10;
        n.value = 20;

        int a = n.data + 10;
        int b = 3 * n.value;
        int c = a + b;
        System.out.println(a);
        System.out.println(b);
        System.out.println(c);
    }
}