package model;
import java.util.Date;

public class Booking {
    private long id;
    private Customer customer;
    private Date departureDate;
    private int noAdults;
    private int noChildren;
    private Tour tour;

    public Booking(long id, Customer customer, Tour tour, Date departureDate, int noAdults, int noChildren) {
        this.id = id;
        this.customer = customer;
        this.tour = tour;
        this.departureDate = departureDate;
        this.noAdults = noAdults;
        this.noChildren = noChildren;
    }
    
    public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public void setDepartureDate(Date departureDate) {
		this.departureDate = departureDate;
	}

	public void setNoAdults(int noAdults) {
		this.noAdults = noAdults;
	}

	public void setNoChildren(int noChildren) {
		this.noChildren = noChildren;
	}

	public void setTour(Tour tour) {
		this.tour = tour;
	}

	// Getters
    public Customer getCustomer() { return customer; }
    public Tour getTour() { return tour; }
    public Date getDepartureDate() { return departureDate; }
    public int getNoAdults() { return noAdults; }
    public int getNoChildren() { return noChildren; }
}