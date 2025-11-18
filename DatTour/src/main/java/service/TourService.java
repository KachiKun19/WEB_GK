package service;

import model.Booking;
import model.Customer;
import model.Tour;
import java.util.ArrayList;
import java.util.List;

public class TourService {
    // Giả lập Database bằng List
    private static List<Tour> tours = new ArrayList<>();
    private static List<Customer> customers = new ArrayList<>();
    private static List<Booking> bookings = new ArrayList<>();

    // Khởi tạo dữ liệu mẫu cho Tour
    static {
        tours.add(new Tour(1, "PHÚ QUỐC (Khuyến mãi mùa hè)", "3 ngày 2 đêm", "Máy bay", "Hàng ngày", 1595000, "Khám phá đảo ngọc Phú Quốc..."));
        tours.add(new Tour(2, "NHA TRANG", "2 ngày 2 đêm", "Tàu hỏa", "Tối thứ 6 và CN", 1540000, "Tham quan Vinpearl Land, tắm bùn khoáng..."));
        tours.add(new Tour(3, "CÔN ĐẢO", "3 ngày 2 đêm", "Máy bay", "Hàng ngày", 1345000, "Viếng mộ chị Võ Thị Sáu, nhà tù Côn Đảo..."));
        tours.add(new Tour(4, "PHAN THIẾT - MŨI NÉ", "2 ngày 1 đêm", "Xe khách", "Thứ 7 mỗi tuần", 1250000, "Đồi cát bay, Hòn Rơm..."));
    }

    public List<Tour> getAllTours() {
        return tours;
    }

    public Tour getTour(long id) {
        for (Tour t : tours) {
            if (t.getId() == id) return t;
        }
        return null;
    }

    // Lưu khách hàng vào danh sách
    public void saveCustomer(Customer customer) {
        customers.add(customer);
        System.out.println("Đã lưu Customer: " + customer.getName());
    }

    // Lưu Booking vào danh sách
    public void saveBooking(Booking booking) {
        bookings.add(booking);
        System.out.println("Đã lưu Booking cho tour: " + booking.getTour().getDescription());
    }
}