interface Command {
    void execute();
}

class LightOnCommand implements Command {
    private Light light;

    public LightOnCommand(Light light) {
        this.light = light;
    }

    @Override
    public void execute() {
        light.on();
    }
}

class LightOffCommand implements Command {
    private Light light;

    public LightOffCommand(Light light) {
        this.light = light;
    }

    @Override
    public void execute() {
        light.off();
    }
}

class RemoteControl {
    private Command command;

    public void setCommand(Command command) {
        this.command = command;
    }

    public void pressButton() {
        if (command != null) {
            command.execute();
        } else {
            System.out.println("No command set.");
        }
    }
}

class Light {
    private String location;

    public Light(String location) {
        this.location = location;
    }

    public void on() {
        System.out.println(location + " light is ON");
    }

    public void off() {
        System.out.println(location + " light is OFF");
    }
}

public class CommandPatternExample {

    public static void main(String[] args) {
        Light livingRoomLight = new Light("Living Room");
        Light kitchenLight = new Light("Kitchen");

        Command livingRoomLightOn = new LightOnCommand(livingRoomLight);
        Command livingRoomLightOff = new LightOffCommand(livingRoomLight);
        Command kitchenLightOn = new LightOnCommand(kitchenLight);
        Command kitchenLightOff = new LightOffCommand(kitchenLight);

        RemoteControl remote = new RemoteControl();

        // Turn on the living room light
        remote.setCommand(livingRoomLightOn);
        remote.pressButton();

        // Turn off the living room light
        remote.setCommand(livingRoomLightOff);
        remote.pressButton();

        // Turn on the kitchen light
        remote.setCommand(kitchenLightOn);
        remote.pressButton();

        // Turn off the kitchen light
        remote.setCommand(kitchenLightOff);
        remote.pressButton();
    }
}
