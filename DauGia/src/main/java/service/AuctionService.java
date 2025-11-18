package service;
import model.*;
import java.util.*;

public class AuctionService {
    // Dùng static để giữ dữ liệu trong bộ nhớ khi server chạy
    private static List<User> users = new ArrayList<>();
    private static List<AuctionItem> items = new ArrayList<>();

    static {
        // Tạo user mẫu
        users.add(new User("khanh", "khanh", "Do Cao Huy", "traiitnhs@yahoo.com", "Tan Binh, HCM"));
        users.add(new User("khanhngo", "123", "Nguyen Van A", "huy@test.com", "Quan 1, HCM"));

        // Tạo sản phẩm mẫu giống trong ảnh
        items.add(new AuctionItem("1", "Máy chụp hình Canon IXY 910 IS (8.0 MP)", 100000, 10000));
        items.add(new AuctionItem("2", "Laptop Acer 3680-2682 hàng xách tay ! Chất lượng hoàn hảo", 3000000, 50000));
        items.add(new AuctionItem("3", "Máy nghe nhạc APPLE IPHONE 16GB", 500000, 20000));
        items.add(new AuctionItem("4", "Bán gấp Nokia N72 chính hãng", 2600000, 50000));
    }

    // Xác thực đăng nhập
    public User authenticateUser(String username, String password) {
        for (User u : users) {
            if (u.getUsername().equals(username) && u.getPassword().equals(password)) {
                return u;
            }
        }
        return null;
    }

    public List<AuctionItem> getAllAuctionItems() {
        return items;
    }

    public AuctionItem getAuctionItem(String id) {
        for (AuctionItem item : items) {
            if (item.getId().equals(id)) return item;
        }
        return null;
    }

    // Logic đặt giá: Trả về true nếu thành công, false nếu giá không hợp lệ
    public boolean placeBid(User user, String itemId, double amount) {
        AuctionItem item = getAuctionItem(itemId);
        if (item == null) return false;

        // Quy tắc: Giá đặt >= Giá hiện tại + Bước giá
        // Lưu ý: Nếu chưa ai đặt, thì giá đặt >= Giá khởi điểm + Bước giá (hoặc >= giá khởi điểm tuỳ nghiệp vụ)
        // Theo đề bài: lớn hơn (giá hiện thời + bước giá)
        double minValidPrice = item.getCurrentPrice() + item.getStepPrice();
        
        if (amount >= minValidPrice) {
            item.addBid(new Bid(user, amount));
            return true;
        }
        return false;
    }
}