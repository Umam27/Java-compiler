public class test_4 {
    public static void matrixMultiplication(int[][] mat1, int[][] mat2, int[][] result) {
        int m1 = mat1.length;
        int n1 = mat1[0].length;
        int m2 = mat2.length;
        int n2 = mat2[0].length;

        if (n1 != m2) {
            System.out.println("Matrices cannot be multiplied!");
            return;
        }

        for (int i = 0; i < m1; i++) {
            for (int j = 0; j < n2; j++) {
                for (int k = 0; k < n1; k++) {
                    result[i][j] += mat1[i][k] * mat2[k][j];
                }
            }
        }
    }

    public static void main(String[] args) {
        int[][] mat1 = {{1, 2, 3}, {4, 5, 6}, {7, 8, 9}};
        int[][] mat2 = {{1, 2}, {3, 4}, {5, 6}};
        int[][] result = new int[3][2];
        matrixMultiplication(mat1, mat2, result);

        System.out.println("Resultant matrix:");
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 2; j++) {
                System.out.print(result[i][j] + " ");
            }
            System.out.println();
        }
    }
}
