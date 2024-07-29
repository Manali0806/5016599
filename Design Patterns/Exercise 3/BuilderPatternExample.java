class Computer {
    // Attributes of the Computer
    private String CPU;
    private String RAM;
    private String storage;
    private String graphicsCard;
    private String powerSupply;
    private String coolingSystem;
    private String motherboard;

    // Private constructor
    private Computer(Builder builder) {
        this.CPU = builder.CPU;
        this.RAM = builder.RAM;
        this.storage = builder.storage;
        this.graphicsCard = builder.graphicsCard;
        this.powerSupply = builder.powerSupply;
        this.coolingSystem = builder.coolingSystem;
        this.motherboard = builder.motherboard;
    }

    // Static nested Builder class
    public static class Builder {
        // Attributes of the Builder
        private String CPU;
        private String RAM;
        private String storage;
        private String graphicsCard;
        private String powerSupply;
        private String coolingSystem;
        private String motherboard;

        // Methods to set each attribute
        public Builder setCPU(String CPU) {
            this.CPU = CPU;
            return this;
        }

        public Builder setRAM(String RAM) {
            this.RAM = RAM;
            return this;
        }

        public Builder setStorage(String storage) {
            this.storage = storage;
            return this;
        }

        public Builder setGraphicsCard(String graphicsCard) {
            this.graphicsCard = graphicsCard;
            return this;
        }

        public Builder setPowerSupply(String powerSupply) {
            this.powerSupply = powerSupply;
            return this;
        }

        public Builder setCoolingSystem(String coolingSystem) {
            this.coolingSystem = coolingSystem;
            return this;
        }

        public Builder setMotherboard(String motherboard) {
            this.motherboard = motherboard;
            return this;
        }

        // Build method to create an instance of Computer
        public Computer build() {
            return new Computer(this);
        }
    }

    // Override toString method to display computer configuration
    @Override
    public String toString() {
        return "Computer{" +
                "CPU='" + CPU + '\'' +
                ", RAM='" + RAM + '\'' +
                ", storage='" + storage + '\'' +
                ", graphicsCard='" + graphicsCard + '\'' +
                ", powerSupply='" + powerSupply + '\'' +
                ", coolingSystem='" + coolingSystem + '\'' +
                ", motherboard='" + motherboard + '\'' +
                '}';
    }
}


public class BuilderPatternExample {
    public static void main(String[] args) {
        // Create a Computer using the Builder pattern
        Computer gamingPC = new Computer.Builder()
                .setCPU("Intel Core i9")
                .setRAM("32GB")
                .setStorage("1TB SSD")
                .setGraphicsCard("NVIDIA RTX 3080")
                .setPowerSupply("750W")
                .setCoolingSystem("Liquid Cooling")
                .setMotherboard("ASUS ROG Maximus")
                .build();

        // Create another Computer with different configuration
        Computer officePC = new Computer.Builder()
                .setCPU("Intel Core i5")
                .setRAM("16GB")
                .setStorage("512GB SSD")
                .setGraphicsCard("Integrated Graphics")
                .setPowerSupply("500W")
                .setCoolingSystem("Air Cooling")
                .setMotherboard("Gigabyte B450M")
                .build();

        // Display the configurations
        System.out.println("Gaming PC Configuration:");
        System.out.println(gamingPC);

        System.out.println("\nOffice PC Configuration:");
        System.out.println(officePC);
    }
}

