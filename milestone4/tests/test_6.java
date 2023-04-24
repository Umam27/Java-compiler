public class test_6 {
    public static void main() {
        int[][] arr1 = new int[3][2], arr2 = new int[4][5];
        int[] arr3[][] = new int[6][2][4];
        int arr4[][][] = new int[7][2][4];

        int a = 2, b = 1;
        int c;

        arr1[a][b] = 10;
        c = arr1[a][b] + a;

        System.out.println(c);
    }
}