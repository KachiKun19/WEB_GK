package model;
import java.util.ArrayList;
import java.util.List;

public class AuctionItem {
    private String id;
    private String description;
    private double initialPrice;
    private double stepPrice;
    private List<Bid> bids = new ArrayList<>();

    public AuctionItem(String id, String description, double initialPrice, double stepPrice) {
        this.id = id;
        this.description = description;
        this.initialPrice = initialPrice;
        this.stepPrice = stepPrice;
    }

    public String getId() { return id; }
    public String getDescription() { return description; }
    public double getInitialPrice() { return initialPrice; }
    public double getStepPrice() { return stepPrice; }
    public int getBidCount() { return bids.size(); }

    // Lấy giá hiện tại (Nếu chưa ai đặt thì là giá khởi điểm, nếu có rồi thì là giá cao nhất)
    public double getCurrentPrice() {
        if (bids.isEmpty()) {
            return initialPrice;
        }
        return bids.get(bids.size() - 1).getAmount();
    }

    // Thêm lượt đấu giá
    public void addBid(Bid bid) {
        this.bids.add(bid);
    }
}