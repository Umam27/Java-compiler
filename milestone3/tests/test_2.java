public class test_2 {
    public static void selectionSort(int[] arr) {
        int n = arr.length;
        for (int i = 0; i < n - 1; i++) {
            int minIndex = i;
            j=i+1;
            while(j < n) {
                // if (arr[j] < arr[minIndex]) {
                //     minIndex = j;
                // }
                // j++;
            }
            int temp = arr[minIndex];
            arr[minIndex] = arr[i];
            arr[i] = temp;
        }
    }

    public static void main(String[] args) {
        int[] arr = { 5, 4, 3, 2, 2.3 };
        selectionSort(arr);
        System.out.print("Sorted array: ");
        for (int i=0;i<5; i++) {
            System.out.print(arr[i] + " ");
        }
    }
}
