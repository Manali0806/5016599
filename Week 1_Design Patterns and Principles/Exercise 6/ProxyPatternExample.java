interface Image {
    void display();
}

class RealImage implements Image {
    private String filename;

    public RealImage(String filename) {
        this.filename = filename;
        loadImageFromServer();
    }

    private void loadImageFromServer() {
        // Simulate a time-consuming operation
        System.out.println("Loading " + filename + " from remote server...");
    }

    @Override
    public void display() {
        System.out.println("Displaying " + filename);
    }
}

class ProxyImage implements Image {
    private String filename;
    private RealImage realImage;

    public ProxyImage(String filename) {
        this.filename = filename;
    }

    @Override
    public void display() {
        if (realImage == null) {
            realImage = new RealImage(filename);
        }
        realImage.display();
    }
}

public class ProxyPatternExample {

    public static void main(String[] args) {
        Image image1 = new ProxyImage("image1.jpg");
        Image image2 = new ProxyImage("image2.jpg");

        // Image will be loaded from remote server
        image1.display();
        System.out.println();

        // Image will not be loaded from remote server (cached)
        image1.display();
        System.out.println();

        // Image will be loaded from remote server
        image2.display();
        System.out.println();

        // Image will not be loaded from remote server (cached)
        image2.display();
    }
}
