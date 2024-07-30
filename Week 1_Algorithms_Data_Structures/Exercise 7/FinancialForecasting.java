import java.util.HashMap;
import java.util.Map;

public class FinancialForecasting {
    private static Map<Integer, Double> memo = new HashMap<>();

    // Method to calculate future value recursively with memoization
    public static double calculateFutureValue(double initialValue, double growthRate, int years) {
        if (years == 0) {
            return initialValue;
        }

        if (memo.containsKey(years)) {
            return memo.get(years);
        }

        double futureValue = calculateFutureValue(initialValue * (1 + growthRate), growthRate, years - 1);
        memo.put(years, futureValue);
        return futureValue;
    }

    public static void main(String[] args) {
        double initialValue = 1000.0; // Initial investment
        double growthRate = 0.05;     // 5% growth rate
        int years = 10;               // Forecast for 10 years

        System.out.printf("The initial investment is: %.2f%n",initialValue);
        System.out.printf("The growth rate is: %.2f%n",growthRate);
        System.out.printf("Number of years is: %d%n",years);

        double futureValue = calculateFutureValue(initialValue, growthRate, years);
        System.out.printf("Future Value after %d years: %.2f%n", years, futureValue);
    }
}
