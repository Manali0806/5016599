// Notifier Interface
interface Notifier {
    void send(String message);
}

// Concrete Component
class EmailNotifier implements Notifier {
    @Override
    public void send(String message) {
        System.out.println("Sending email notification: " + message);
    }
}

// Abstract Decorator Class
abstract class NotifierDecorator implements Notifier {
    protected Notifier wrappedNotifier;

    public NotifierDecorator(Notifier notifier) {
        this.wrappedNotifier = notifier;
    }

    @Override
    public void send(String message) {
        wrappedNotifier.send(message);
    }
}

// Concrete Decorator Class for SMS
class SMSNotifierDecorator extends NotifierDecorator {
    public SMSNotifierDecorator(Notifier notifier) {
        super(notifier);
    }

    @Override
    public void send(String message) {
        super.send(message);
        sendSMS(message);
    }

    private void sendSMS(String message) {
        System.out.println("Sending SMS notification: " + message);
    }
}

// Concrete Decorator Class for Slack
class SlackNotifierDecorator extends NotifierDecorator {
    public SlackNotifierDecorator(Notifier notifier) {
        super(notifier);
    }

    @Override
    public void send(String message) {
        super.send(message);
        sendSlack(message);
    }

    private void sendSlack(String message) {
        System.out.println("Sending Slack notification: " + message);
    }
}

public class DecoratorPatternExample {
    public static void main(String[] args) {
        // Create an EmailNotifier
        Notifier emailNotifier = new EmailNotifier();

        // Decorate the EmailNotifier with SMSNotifier
        Notifier emailAndSMSNotifier = new SMSNotifierDecorator(emailNotifier);

        // Decorate the EmailNotifier with SMSNotifier and SlackNotifier
        Notifier emailSMSAndSlackNotifier = new SlackNotifierDecorator(emailAndSMSNotifier);

        // Send notifications
        System.out.println("Sending notification via Email and SMS:");
        emailAndSMSNotifier.send("Hello!");

        System.out.println("\nSending notification via Email, SMS, and Slack:");
        emailSMSAndSlackNotifier.send("Hello!");
    }
}
