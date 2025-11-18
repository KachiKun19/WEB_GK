package model;

import java.util.Calendar;
import java.util.Date;

public class Entry {
	protected long id;
	protected String title;
	protected Date createdTime;
	protected String content;
	protected User creator;

	public Entry(String title, String content, User creator) {
		this.id = System.currentTimeMillis(); 
		this.title = title;
		this.content = content;
		this.creator = creator;
		this.createdTime = new Date();
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public void setCreatedTime(Date createdTime) {
		this.createdTime = createdTime;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public void setCreator(User creator) {
		this.creator = creator;
	}

	public String getTitle() {
		return title;
	}

	public User getCreator() {
		return creator;
	}

	public Date getCreatedTime() {
		return createdTime;
	}

	public String getContent() {
		return content;
	}
}