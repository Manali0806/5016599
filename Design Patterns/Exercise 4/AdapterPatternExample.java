// Target Interface
interface PaymentProcessor {
    void processPayment(double amount);
}

// Adaptee 1: PayPal Payment Gateway
class PayPalPayment {
    public void makePayment(double amount) {
        System.out.println("Processing payment of $" + amount + " through PayPal.");
    }
}

// Adaptee 2: Stripe Payment Gateway
class StripePayment {
    public void sendPayment(double amount) {
        System.out.println("Processing payment of $" + amount + " through Stripe.");
    }
}

// Adaptee 3: Square Payment Gateway
class SquarePayment {
    public void pay(double amount) {
        System.out.println("Processing payment of $" + amount + " through Square.");
    }
}

// Adapter for PayPal
class PayPalPaymentAdapter implements PaymentProcessor {
    private PayPalPayment payPalPayment;

    public PayPalPaymentAdapter(PayPalPayment payPalPayment) {
        this.payPalPayment = payPalPayment;
    }

    @Override
    public void processPayment(double amount) {
        payPalPayment.makePayment(amount);
    }
}

// Adapter for Stripe
class StripePaymentAdapter implements PaymentProcessor {
    private StripePayment stripePayment;

    public StripePaymentAdapter(StripePayment stripePayment) {
        this.stripePayment = stripePayment;
    }

    @Override
    public void processPayment(double amount) {
        stripePayment.sendPayment(amount);
    }
}

// Adapter for Square
class SquarePaymentAdapter implements PaymentProcessor {
    private SquarePayment squarePayment;

    public SquarePaymentAdapter(SquarePayment squarePayment) {
        this.squarePayment = squarePayment;
    }

    @Override
    public void processPayment(double amount) {
        squarePayment.pay(amount);
    }
}

public class AdapterPatternExample {
    public static void main(String[] args) {
        // Create instances of payment gateways
        PayPalPayment payPalPayment = new PayPalPayment();
        StripePayment stripePayment = new StripePayment();
        SquarePayment squarePayment = new SquarePayment();

        // Create adapters for payment gateways
        PaymentProcessor payPalAdapter = new PayPalPaymentAdapter(payPalPayment);
        PaymentProcessor stripeAdapter = new StripePaymentAdapter(stripePayment);
        PaymentProcessor squareAdapter = new SquarePaymentAdapter(squarePayment);

        // Process payments using adapters
        System.out.println("Using PayPal Adapter:");
        payPalAdapter.processPayment(100.00);

        System.out.println("Using Stripe Adapter:");
        stripeAdapter.processPayment(200.00);

        System.out.println("Using Square Adapter:");
        squareAdapter.processPayment(300.00);
    }
}

