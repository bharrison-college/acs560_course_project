package edu.ipfw.acs.model;

import javax.persistence.*;

@Entity
@Table(name="CAVLab")
public class CAVLab {
	
	@Id
	@Column(name="id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;
	
	@Column(name="labStatsCode")
	private String labStatsCode;
	
	@Column(name="longitude")
	private String longitude;
	
	@Column(name="latitude")
	private String latitude;
	
	@Column(name="building")
	private String building;
	
	@Column(name="room")
	private String room;

	@Column(name="detailedDescription")
	private String detailedDescription;
	
	@Column(name="availableCapacity")
	private String availableCapacity;
	
	@Column(name="inUse")
	private String inUse;
	
	@Column(name="off")
	private String off;
	
	public String getRoom() {
		return room;
	}
	public void setRoom(String room) {
		this.room = room;
	}
	public String getLabStatsCode() {
		return labStatsCode;
	}
	public void setLabStatsCode(String labStatsCode) {
		this.labStatsCode = labStatsCode;
	}
	
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getBuilding() {
		return building;
	}
	public void setBuilding(String building) {
		this.building = building;
	}
	public String getDetailedDescription() {
		return detailedDescription;
	}
	public void setDetailedDescription(String detailedDescription) {
		this.detailedDescription = detailedDescription;
	}
	public String getAvailableCapacity() {
		return availableCapacity;
	}
	public void setAvailableCapacity(String availableCapacity) {
		this.availableCapacity = availableCapacity;
	}
	public String getInUse() {
		return inUse;
	}
	public void setInUse(String inUse) {
		this.inUse = inUse;
	}
	public String getOff() {
		return off;
	}
	public void setOff(String off) {
		this.off = off;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
}
