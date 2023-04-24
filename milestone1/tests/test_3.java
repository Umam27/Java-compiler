public class test_3 {
    private static final int MAX_SIZE = 100;
    private int top;
    private int[] stackArray;

    public test_3() {
        top = -1;
        stackArray = new int[MAX_SIZE];
    }

    public void push(int data) {
        if (top == MAX_SIZE - 1) {
            System.out.println("Stack overflow!");
            return;
        }
        stackArray[++top] = data;
    }

    public int pop() {
        if (top == -1) {
            System.out.println("Stack underflow!");
            return -1;
        }
        return stackArray[top--];
    }

    public boolean isEmpty() {
        return top == -1;
    }

    public static void main(String[] args) {
        test_3 stack = new test_3();
        stack.push(10);
        stack.push(20);
        stack.push(30);
        System.out.println(stack.pop() + " popped from stack");
        System.out.println(stack.pop() + " popped from stack");
        System.out.println(stack.pop() + " popped from stack");
    }
}
