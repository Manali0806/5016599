
import java.util.*;

class Logger{
    private static Logger instance; //private static instance for logger class
    private Logger(){ //private constuctor

    }
    public static Logger getInstance(){ //public method to get instance of the Logger class
        
        if(instance==null){
            instance = new Logger();
        }
        return instance;
    }

    public void log(String message){
        System.out.println(message);
    }
}

public class SingletonPatternExample{
    public static void main(String[] args){
        Logger logger1 = Logger.getInstance();
        logger1.log("First Log Message");

        Logger logger2 = Logger.getInstance();
        logger2.log("Second Log Message");

        if(logger1==logger2){
            System.out.println("Both have same instances");
        }
        else{
            System.out.println("Both have different instances");
        }
    }
}