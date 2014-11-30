<%@ page import="java.util.ArrayList" %>
<%@ page import="edu.ipfw.acs.model.CAVLab" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
<c:forEach items="${cavLabs}" var="cavLab"> 
	<key>offs</key>
	<array>
		<integer>${cavLab.getOff()}</integer>
		<integer>3</integer>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
	</array>
	<key>inUses</key>
	<array>
		<integer>10</integer>
		<integer>5</integer>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
	</array>
	<key>availableCapacities</key>
	<array>
		<integer>20</integer>
		<integer>8</integer>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
	</array>
	<key>detailedDescriptions</key>
	<array>
		<string>Walb is located across from Helmke Library and also from the Rhinehart Music Center. This computer lab is on the second floor.</string>
		<string>Visual Arts is located across from ..</string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
	</array>
	<key>buildings</key>
	<array>
		<string>Walb</string>
		<string>Visual Arts</string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
	</array>
	<key>rooms</key>
	<array>
		<string>221</string>
		<string>205</string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
	</array>
	<key>latitudes</key>
	<array>
		<real>41.118003</real>
		<real>41.120709</real>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
	</array>
	<key>longitudes</key>
	<array>
		<real>-85.108581</real>
		<real>-85.109433</real>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
	</array>
	<key>labStatsCodes</key>
	<array>
		<string>WU_221</string>
		<string>VA_205</string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
		<string></string>
	</array>
	</c:forEach>
</dict>
</plist>