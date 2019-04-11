import Foundation


let annotationLocations = [
    ["title": "Will Skelton Greenway", "rackType":"hoop", "address": "2225 Estelle Circle", "latitude":35.961614, "longitude": -83.882901],
    ["title": "Ned McWheter Park", "rackType":"hoop", "address": "1648 Riverside", "latitude":35.963440, "longitude": -83.896666],
    ["title": "Burlington Branch Library", "rackType":"hoop", "address": "4614 Asheville Hwy", "latitude":36.004390, "longitude": -83.859357]
]

var i = 0;
var currentLatitude = 35.961613
var currentLongitude = -83.882901

for object in annotationLocations{

    if let actualLongitude = object["longitude"] as? Double, let actualLatitude = object["latitude"] as? Double {
     print(i, ": longitude = ", actualLongitude, "   latitude = ", actualLatitude)
     
     var distanceLatitude = actualLatitude - currentLatitude
     if distanceLatitude < 0{
         distanceLatitude *= -1
     }

     distanceLatitude = round(distanceLatitude * 1000000)/1000000 // <-- formatting nmber to millionth place

     var distanceLongitude = actualLongitude - currentLongitude
     distanceLongitude = round(distanceLongitude * 1000000)/1000000
     if distanceLongitude < 0 {
         distanceLongitude *= -1
     }
     
     var distance = distanceLatitude + distanceLongitude

     print(distance)
 

    }

    i += 1
}

print ("\n")

// If u want specific index, do this: Index = 0
if let actualLongitude = annotationLocations[0]["title"] {
    print (actualLongitude)
}
