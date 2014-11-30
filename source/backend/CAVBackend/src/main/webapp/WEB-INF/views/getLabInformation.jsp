<%@ page import="java.util.ArrayList" %>
<%@ page import="edu.ipfw.acs.model.CAVLab" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  

<c:if test="${cavLabs != null}">
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
<c:forEach items="${cavLabs}" var="cavLab"> 
	<key>offs</key>
	<array>
		<integer>${cavLab.off}</integer>
	</array>
	<key>inUses</key>
	<array>
		<integer>${cavLab.inUse}</integer>
	</array>
	<key>availableCapacities</key>
	<array>
		<integer>${cavLab.availableCapacity}</integer>
	</array>
	<key>detailedDescriptions</key>
	<array>
		<string>${cavLab.detailedDescription}</string>
	</array>
	<key>buildings</key>
	<array>
		<string>${cavLab.building}</string>
	</array>
	<key>rooms</key>
	<array>
		<string>${cavLab.room}</string>
	</array>
	<key>latitudes</key>
	<array>
		<real>${cavLab.latitude}</real>
	</array>
	<key>longitudes</key>
	<array>
		<real>${cavLab.longitude}</real>
	</array>
	<key>labStatsCodes</key>
	<array>
		<string>${cavLab.labStatsCode}</string>
	</array>
	</c:forEach>
</dict>
</plist>
</c:if>