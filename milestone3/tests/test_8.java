public class test_8 {
    public static void main(String[] args) {
        int a = 5;
        int b = 3;

        // Arithmetic operators
        int sum = a + b;
        int diff = a - b;
        int product = a * b;
        int quotient = a / b;
        int remainder = a % b;
        ++a;
        b--;
        int postIncrement = a++;
        int preDecrement = --b;

        // Relational operators
        boolean isEqual = a == b;
        boolean isNotEqual = a != b;
        boolean isGreater = a > b;
        boolean isLess = a < b;
        boolean isGreaterOrEqual = a >= b;
        boolean isLessOrEqual = a <= b;

        // Bitwise operators
        int bitwiseAnd = a & b;
        int bitwiseOr = a | b;
        int bitwiseXor = a ^ b;
        int bitwiseComplement = ~a;
        int leftShift = a << 2;
        int rightShift = a >> 2;
        int unsignedRightShift = a >>> 2;

        // Logical operators
        boolean andOperator = isEqual && isNotEqual;
        boolean orOperator = isGreater || isLess;
        boolean notOperator = !andOperator;

        // Assignment operators
        a += 2;
        b -= 2;
        a *= b;
        a /= b;
        a &= b;

        // Ternary operator
        int max = (a > b) ? a : b;
        System.out.println("Max value: " + max);
    }
}
