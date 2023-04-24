public class test_12 {
    public static void main(String[] args) {
        // Implicit type casting (widening conversion)
        int a = 10;
        double b = a;
        System.out.println("a = " + a + ", b = " + b); // prints "a = 10, b = 10.0"

        // Explicit type casting (narrowing conversion)
        double c = 10.5;
        int d = (int) c;
        System.out.println("c = " + c + ", d = " + d); // prints "c = 10.5, d = 10"

        // Type casting with objects (downcasting)
        Animal animal = new Dog();
        animal.makeSound(); // prints "The dog barks"
        Dog dog = (Dog) animal;
        dog.playFetch();    // calls the playFetch method on the Dog object

        // Type casting with objects (upcasting)
        Dog dog2 = new Dog();
        dog2.makeSound();   // prints "The dog barks"
        Animal animal2 = dog2;
        animal2.makeSound(); // also prints "The dog barks"
    }
}

class Animal {
    void makeSound() {
        System.out.println("The animal makes a sound");
    }
}

class Dog extends Animal {
    void makeSound() {
        System.out.println("The dog barks");
    }

    void playFetch() {
        System.out.println("The dog plays fetch");
    }
}
