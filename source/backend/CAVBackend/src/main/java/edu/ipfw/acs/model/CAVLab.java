package edu.ipfw.acs.model;

import javax.persistence.*;

@Entity
@Table(name="CAVLab")
public class CAVLab {
	
	@Id
	@Column(name="id")
	String id;
	
	@Column(name="longitude")
	String longitude;
	
	@Column(name="latitude")
	String latitude;
	
	@Column(name="building")
	String building;
	
	@Column(name="previewDescription")
	String previewDescription;
	
	public String getPreviewDescription() {
		return previewDescription;
	}
	public void setPreviewDescription(String previewDescription) {
		this.previewDescription = previewDescription;
	}
	@Column(name="detailedDescription")
	String detailedDescription;
	
	@Column(name="availableCapacity")
	String availableCapacity;
	
	@Column(name="inUse")
	String inUse;
	
	@Column(name="off")
	String off;
	
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
