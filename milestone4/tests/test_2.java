public class test_2 {
    public static void main() {
        int decision = 0;

        if (decision == 0) {
            System.out.println(0);
        } else {
            System.out.println(1);
        }

        if (decision == 1) {
            System.out.println(1);
        } else {
            System.out.println(0);
        }

        int i = 0;
        for( i = 0; i < 10; i++) {
            if(i == 5){
                continue;
            }
            if(i == 8) {
                break;
            }
            System.out.println(i);
        }

        while(decision <= 10) {
            System.out.println(decision);
            decision++;
        }
        System.out.println(decision);
        do {
            System.out.println(decision);
            decision--;
        } while(decision > 0);
    }
}
