package model;
public class User {
    private String username;
    private String password;
    private String companyName;
    private String email;
    private String address;

    public User(String username, String password, String companyName, String email, String address) {
        this.username = username;
        this.password = password;
        this.companyName = companyName;
        this.email = email;
        this.address = address;
    }
    
    public String getUsername() { return username; }
    public String getPassword() { return password; }
    public String getCompanyName() { return companyName; }
    public String getEmail() { return email; }
    public String getAddress() { return address; }
}