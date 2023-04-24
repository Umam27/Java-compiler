public class test_3 {
    public static int method2(int s){
        return s;
    }

    public static int method1(){
        int size = 5;
        return method2(size);
    }

    public static void main() {
        System.out.println(method1());
    }
}
