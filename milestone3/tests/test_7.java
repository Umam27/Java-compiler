public class Node {
    int data;
    Node next;
}

public class test_7 {
    private Node front, rear;

    public test_7() {
        // this.front = this.rear = null;
    }

    public boolean isEmpty() {
        return front == null;
    }

    public void enqueue(int data) {
        Node newNode = new Node();
        newNode.data = data;

        if (rear == null) {
            front = rear = newNode;
            return;
        }

        rear.next = newNode;
        rear = newNode;
    }

    public int dequeue() {
        if (isEmpty()) {
            throw new RuntimeException("Queue is empty");
        }

        int data = front.data;
        front = front.next;

        if (front == null) {
            rear = null;
        }

        return data;
    }

    public int peek() {
        if (isEmpty()) {
            throw new RuntimeException("Queue is empty");
        }

        return front.data;
    }

    public static void main(String[] args) {
        test_7 queue = new test_7();

        queue.enqueue(10);
        queue.enqueue(20);
        queue.enqueue(30);

        System.out.println("Dequeued item: " + queue.dequeue());
        System.out.println("Peek item: " + queue.peek());
    }
}
