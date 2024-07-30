import java.util.Arrays;
import java.util.Comparator;

class Product {
    private String productId;
    private String productName;
    private String category;

    // Constructor
    public Product(String productId, String productName, String category) {
        this.productId = productId;
        this.productName = productName;
        this.category = category;
    }

    // Getters
    public String getProductId() {
        return productId;
    }

    public String getProductName() {
        return productName;
    }

    public String getCategory() {
        return category;
    }

    @Override
    public String toString() {
        return "Product [productId=" + productId + ", productName=" + productName + ", category=" + category + "]";
    }
}

class SearchAlgorithms {

    // Linear Search
    public static Product linearSearch(Product[] products, String targetProductId) {
        for (Product product : products) {
            if (product.getProductId().equals(targetProductId)) {
                return product;
            }
        }
        return null; // Product not found
    }

    // Binary Search
    public static Product binarySearch(Product[] products, String targetProductId) {
        int left = 0;
        int right = products.length - 1;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            Product midProduct = products[mid];
            int comparison = midProduct.getProductId().compareTo(targetProductId);

            if (comparison == 0) {
                return midProduct;
            } else if (comparison < 0) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return null; // Product not found
    }
}

class SortUtils {
    public static void sortProductsById(Product[] products) {
        Arrays.sort(products, Comparator.comparing(Product::getProductId));
    }
}

public class EcommerceSearch {

    public static void main(String[] args) {
        Product[] products = {
            new Product("3", "Laptop", "Electronics"),
            new Product("1", "Smartphone", "Electronics"),
            new Product("2", "Tablet", "Electronics")
        };

        System.out.println("Original Array:");
        for (Product product : products) {
            System.out.println(product);
        }

        // Linear Search
        Product foundProduct = SearchAlgorithms.linearSearch(products, "2");
        System.out.println("\nLinear Search Result:");
        System.out.println(foundProduct != null ? foundProduct : "Product not found");

        // Sort products for Binary Search
        SortUtils.sortProductsById(products);

        System.out.println("\nSorted Array:");
        for (Product product : products) {
            System.out.println(product);
        }

        // Binary Search
        foundProduct = SearchAlgorithms.binarySearch(products, "2");
        System.out.println("\nBinary Search Result:");
        System.out.println(foundProduct != null ? foundProduct : "Product not found");
    }
}
