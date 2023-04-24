import java.util.Random;

public class test_9 {
    public static void main(String[] args) {
        int n = 1000000; // number of random points to generate
        int countInsideCircle = 0; // number of points inside the circle
        
        // generate random points
        Random rand = new Random();
        for (int i = 0; i < n; i++) {
            double x = rand.nextDouble();
            double y = rand.nextDouble();
            
            // check if point is inside circle
            if (x * x + y * y <= 1.0) {
                countInsideCircle++;
            }
        }
        
        // calculate pi value
        double pi = 4.0 * countInsideCircle / n;
        System.out.println("Estimated value of pi: " + pi);
    }
}
