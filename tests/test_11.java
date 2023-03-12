class Animal {
    void makeSound() {
        System.out.println("The animal makes a sound");
    }
}

class Dog extends Animal {
    void makeSound() {
        System.out.println("The dog barks");
    }
}

class Cat extends Animal {
    void makeSound() {
        System.out.println("The cat meows");
    }
}

public class test_11 {
    public static void main(String[] args) {
        Animal animal = new Animal();
        Dog dog = new Dog();
        Cat cat = new Cat();

        animal.makeSound(); // prints "The animal makes a sound"
        dog.makeSound();    // prints "The dog barks"
        cat.makeSound();    // prints "The cat meows"

        Animal animal2 = new Dog();
        animal2.makeSound(); // prints "The dog barks"
    }
}
