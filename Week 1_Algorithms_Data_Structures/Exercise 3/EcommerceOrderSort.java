class Order {
    private String orderId;
    private String customerName;
    private double totalPrice;

    // Constructor
    public Order(String orderId, String customerName, double totalPrice) {
        this.orderId = orderId;
        this.customerName = customerName;
        this.totalPrice = totalPrice;
    }

    // Getters
    public String getOrderId() {
        return orderId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    @Override
    public String toString() {
        return "Order [orderId=" + orderId + ", customerName=" + customerName + ", totalPrice=" + totalPrice + "]";
    }
}

class BubbleSort {

    public static void bubbleSort(Order[] orders) {
        int n = orders.length;
        boolean swapped;

        for (int i = 0; i < n - 1; i++) {
            swapped = false;
            for (int j = 0; j < n - 1 - i; j++) {
                if (orders[j].getTotalPrice() > orders[j + 1].getTotalPrice()) {
                    // Swap orders[j] and orders[j + 1]
                    Order temp = orders[j];
                    orders[j] = orders[j + 1];
                    orders[j + 1] = temp;
                    swapped = true;
                }
            }
            if (!swapped) break; // Array is sorted
        }
    }
}

class QuickSort {

    public static void quickSort(Order[] orders, int low, int high) {
        if (low < high) {
            int pi = partition(orders, low, high);
            quickSort(orders, low, pi - 1);
            quickSort(orders, pi + 1, high);
        }
    }

    private static int partition(Order[] orders, int low, int high) {
        double pivot = orders[high].getTotalPrice();
        int i = low - 1; // Index of smaller element

        for (int j = low; j < high; j++) {
            if (orders[j].getTotalPrice() <= pivot) {
                i++;
                // Swap orders[i] and orders[j]
                Order temp = orders[i];
                orders[i] = orders[j];
                orders[j] = temp;
            }
        }

        // Swap orders[i + 1] and orders[high] (or pivot)
        Order temp = orders[i + 1];
        orders[i + 1] = orders[high];
        orders[high] = temp;

        return i + 1;
    }
}

public class EcommerceOrderSort {

    public static void main(String[] args) {
        Order[] orders = {
            new Order("1", "Alice", 250.75),
            new Order("2", "Bob", 125.50),
            new Order("3", "Charlie", 300.00),
            new Order("4", "David", 175.25)
        };

        System.out.println("Original Orders:");
        for (Order order : orders) {
            System.out.println(order);
        }

        // Bubble Sort
        Order[] bubbleSortedOrders = orders.clone();
        BubbleSort.bubbleSort(bubbleSortedOrders);
        System.out.println("\nOrders Sorted by Bubble Sort:");
        for (Order order : bubbleSortedOrders) {
            System.out.println(order);
        }

        // Quick Sort
        Order[] quickSortedOrders = orders.clone();
        QuickSort.quickSort(quickSortedOrders, 0, quickSortedOrders.length - 1);
        System.out.println("\nOrders Sorted by Quick Sort:");
        for (Order order : quickSortedOrders) {
            System.out.println(order);
        }
    }
}
