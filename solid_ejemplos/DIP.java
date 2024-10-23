package solid_ejemplos;

// Interface para procesar pagos
interface Payment {
    void pay(double amount);
}

// Clase concreta pago con tarjeta de credito
class CreditCardPayment implements Payment {
    @Override
    public void pay(double amount) {
        System.out.println("Pagando " + amount + " con tarjeta de credito");
    }
}

// Clase concreta pago con PayPal
class PayPalPayment implements Payment {
    @Override
    public void pay(double amount) {
        System.out.println("Pagando " + amount + " con PayPal");
    }
}

// Clase que gestiona los pagos
class PaymentProcessor {
    private Payment paymentMethod;

    public PaymentProcessor(Payment paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public void processPayment(double amount) {
        paymentMethod.pay(amount);
    }
}

public class DIP {
    public static void main(String[] args) {
        System.out.println("Dependency Inversion Principle");

        // pago con tarjeta de credito
        Payment creditCardPayment = new CreditCardPayment();
        PaymentProcessor paymentProcessorCard = new PaymentProcessor(creditCardPayment);
        paymentProcessorCard.processPayment(100);

        // pago con PayPal
        Payment payPalPayment = new PayPalPayment();
        PaymentProcessor paymentProcessorPayPal = new PaymentProcessor(payPalPayment);
        paymentProcessorPayPal.processPayment(200);
    }
}



