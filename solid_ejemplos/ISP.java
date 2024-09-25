package solid_ejemplos;

interface LandableVehicle {
    void drive();
}

interface FlyableVehicle {
    void fly();
}

interface SailableVehicle {
    void navigate();
}

class Car implements LandableVehicle {
    @Override
    public void drive() {
        System.out.println("Manejando el auto");
    }
}

class Boat implements SailableVehicle {
    @Override
    public void navigate() {
        System.out.println("Navegando en el bote");
    }
}

class Airplane implements FlyableVehicle {
    @Override
    public void fly() {
        System.out.println("Volando en el avion");
    }
}

class Hydroplane implements FlyableVehicle, SailableVehicle {
    @Override
    public void fly() {
        System.out.println("Volando en el hidroavion");
    }

    @Override
    public void navigate() {
        System.out.println("Navegando en el hidroavion");
    }
}

public class ISP {
    public static void main(String[] args) {
        System.out.println("Interface Segregation Principle");

        Car car = new Car();
        Boat boat = new Boat();
        Airplane airplane = new Airplane();
        Hydroplane hydroplane = new Hydroplane();

        car.drive();
        boat.navigate();
        airplane.fly();
        hydroplane.fly();
        hydroplane.navigate();
    }
}
