package solid_ejemplos;

interface Figura {
    double calcularArea();
}

class Circulo implements Figura {
    private double radio;

    public Circulo(double radio) {
        this.radio = radio;
    }

    @Override
    public double calcularArea() {
        return Math.PI * radio * radio;
    }
}

class Rectangulo implements Figura {
    private double ancho;
    private double largo;

    public Rectangulo(double ancho, double largo) {
        this.ancho = ancho;
        this.largo = largo;
    }

    @Override
    public double calcularArea() {
        return ancho * largo;
    }
}

class CalculadorArea {
    public double calcularArea(Figura figura) {
        return figura.calcularArea(); 
    }
}

public class OCP {
    public static void main(String[] args) {
        System.out.println("Open/Closed Principle");

        CalculadorArea calculator = new CalculadorArea();

        Figura circulo = new Circulo(5);
        System.out.println("Área del círculo: " + calculator.calcularArea(circulo));

        Figura rectangle = new Rectangulo(4, 6);
        System.out.println("Área del rectángulo: " + calculator.calcularArea(rectangle));

        // Si deseamos agregar un triangulo, solo creamos una nueva clase que implemente Figura
    }
}

