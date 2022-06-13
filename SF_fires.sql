
-- Replace all false alarm strings with one string: "False Alarm"
Update SF_Fires..Fire_Incidents Set 
	Situation_text = REPLACE(Situation_text, 'Municipal alarm system, Street Box False', 'False Alarm')
Update SF_Fires..Fire_Incidents Set
	Situation_text = REPLACE(Situation_text, 'False alarm or false call, other', 'False Alarm')
Update SF_Fires..Fire_Incidents Set
	Situation_text = REPLACE(Situation_text, 'Alarm system sounded due to malfunction', 'False Alarm')
Update SF_Fires..Fire_Incidents Set
	Situation_text = REPLACE(Situation_text, 'Alarm system sounded/no fireaccidental', 'False Alarm')
Update SF_Fires..Fire_Incidents Set
	Situation_text = REPLACE(Situation_text, 'Municipal alarm system, malicious false alarm', 'False Alarm')
Update SF_Fires..Fire_Incidents Set
	Situation_text = REPLACE(Situation_text, 'Alarm system activation, no fireunintentional', 'False Alarm')
Update SF_Fires..Fire_Incidents Set
	Situation_text = REPLACE(Situation_text, 'Smoke detector activation, no fireunintentional', 'False Alarm')
Update SF_Fires..Fire_Incidents Set
	Situation_text = REPLACE(Situation_text, 'Unintentional alarm, other', 'False Alarm')
Update SF_Fires..Fire_Incidents Set
	Situation_text = REPLACE(Situation_text, 'Smoke scare, odor of smoke', 'False Alarm')
Update SF_Fires..Fire_Incidents Set
	Situation_text = REPLACE(Situation_text, 'Smoke detector activation/malfunction', 'False Alarm')
Update SF_Fires..Fire_Incidents Set
	Situation_text = REPLACE(Situation_text, 'Good intent call, other', 'False Alarm')
Update SF_Fires..Fire_Incidents Set
	Situation_text = REPLACE(Situation_text, 'Smoke detector, no fire, accidental', 'False Alarm')
Update SF_Fires..Fire_Incidents Set
	Situation_text = REPLACE(Situation_text, 'Smoke detector activation due to malfunction', 'False Alarm')
Update SF_Fires..Fire_Incidents Set
	Situation_text = REPLACE(Situation_text, 'Malicious, mischievous false call, other', 'False Alarm')
Update SF_Fires..Fire_Incidents Set
	Situation_text = REPLACE(Situation_text, 'Detector activation, nofireunintentional', 'False Alarm')
Update SF_Fires..Fire_Incidents Set
	Situation_text = REPLACE(Situation_text, 'Detector activation, nofireaccident', 'False Alarm')
Update SF_Fires..Fire_Incidents Set
	Situation_text = REPLACE(Situation_text, 'No incident found on arrival at dispatch address', 'False Alarm')
Update SF_Fires..Fire_Incidents Set
	Situation_text = REPLACE(Situation_text, 'No incident found on arrival at disp. addr.', 'False Alarm')
Update SF_Fires..Fire_Incidents Set
	Situation_text = REPLACE(Situation_text, 'Central station, malicious false alarm', 'False Alarm')
Update SF_Fires..Fire_Incidents Set
	Situation_text = REPLACE(Situation_text, 'Direct tie to FD, malicious false alarm', 'False Alarm')
Update SF_Fires..Fire_Incidents Set
	Situation_text = REPLACE(Situation_text, 'Local alarm sys., Malicious False alarm', 'False Alarm')
Update SF_Fires..Fire_Incidents Set
	Situation_text = REPLACE(Situation_text, 'Direct tie to FD, malicious/false alarm', 'False Alarm')
Update SF_Fires..Fire_Incidents Set
	Situation_text = REPLACE(Situation_text, 'CO detector activation due to malfunction', 'False Alarm')
Update SF_Fires..Fire_Incidents Set
	Situation_text = REPLACE(Situation_text, 'Sprinkler activation/no fireaccidental', 'False Alarm')
Update SF_Fires..Fire_Incidents Set
	Situation_text = REPLACE(Situation_text, 'Steam/gas mistaken for smoke, other', 'False Alarm')
Update SF_Fires..Fire_Incidents Set
	Situation_text = REPLACE(Situation_text, 'Local alarm system, malicious false alarm', 'False Alarm')
Update SF_Fires..Fire_Incidents Set
	Situation_text = REPLACE(Situation_text, 'Sprinkler activation, no fireunintentional', 'False Alarm')
Update SF_Fires..Fire_Incidents Set
	Situation_text = REPLACE(Situation_text, 'Steam, other gas mistaken for smoke, other', 'False Alarm')
Update SF_Fires..Fire_Incidents Set
	Situation_text = REPLACE(Situation_text, 'Sprinkler activation due to malfunction', 'False Alarm')
Update SF_Fires..Fire_Incidents Set
	Situation_text = REPLACE(Situation_text, 'Telephone, malicious false alarm', 'False Alarm')
Update SF_Fires..Fire_Incidents Set
	Situation_text = REPLACE(Situation_text, 'Steam, vapor, fog, or dust thought to be smoke', 'False Alarm')
Update SF_Fires..Fire_Incidents Set
	Situation_text = REPLACE(Situation_text, 'CO detector activation/malfunction', 'False Alarm')
Update SF_Fires..Fire_Incidents Set
	Situation_text = REPLACE(Situation_text, 'Heat detector activation/malfunction', 'False Alarm')
Update SF_Fires..Fire_Incidents Set
	Situation_text = REPLACE(Situation_text, 'CO detector activation, no CO', 'False Alarm')
Update SF_Fires..Fire_Incidents Set
	Situation_text = REPLACE(Situation_text, 'Exiting. sys. activation/ malfunction', 'False Alarm')
Update SF_Fires..Fire_Incidents Set
	Situation_text = REPLACE(Situation_text, 'Unintentional transmission of alarm, other', 'False Alarm')
Update SF_Fires..Fire_Incidents Set
	Situation_text = REPLACE(Situation_text, 'Detector activation, no fireunintentional', 'False Alarm')
Update SF_Fires..Fire_Incidents Set
	Situation_text = REPLACE(Situation_text, 'Detector activation, no fireaccident', 'False Alarm')
Update SF_Fires..Fire_Incidents Set
	Situation_text = REPLACE(Situation_text, 'No incident found on arrival/disp. addr.', 'False Alarm')
Update SF_Fires..Fire_Incidents Set
	Situation_text = REPLACE(Situation_text, 'Carbon monoxide detector activation, no CO', 'False Alarm')

-- Remove 'False Alarm' rows from the Fire Incidents table	
Delete From SF_Fires..Fire_Incidents Where Situation_text Like '%False Alarm%'

-- Get the day of the week from the dates
Alter Table Fire_Incidents
Add Day_of_week nvarchar(255)
Update Fire_Incidents
Set Day_of_week =  DATENAME(DW, [Incident Date]) From SF_Fires..Fire_Incidents

-- Get the hour from the exact time of the incident
Alter Table Fire_Incidents
Add Hour_of_day int
Update Fire_Incidents
Set Hour_of_day = DATEPART(HOUR, [Alarm DtTm]) From SF_Fires..Fire_Incidents

-- Count frequecies of incidents each combination of hour of day and day of week
Select Day_of_week, Hour_of_day, Count(*) as Count From SF_Fires..Fire_Incidents
Group By Day_of_week, Hour_of_day Order By Hour_of_day 

-- Get the year from the date
Alter Table Fire_Incidents
Add Incident_year int
Update SF_Fires..Fire_Incidents
Set Incident_year = YEAR([Incident Date]) From SF_Fires..Fire_Incidents

-- Calculate how much time it took for department to arrive for each incident
Alter Table Fire_Incidents
Add Arrival_minutes int
Update SF_Fires..Fire_Incidents
Set Arrival_minutes = DATEDIFF(MINUTE, [Alarm DtTm], [Arrival DtTm]) From SF_Fires..Fire_Incidents

Alter Table Fire_Incidents
Add Month_Year nvarchar(255)
Update SF_Fires..Fire_Incidents
Set Month_Year = DATENAME(m, [Incident Date]) + ' ' + CAST(DATEPART(yyyy, [Incident Date]) As varchar) From SF_Fires..Fire_Incidents

-- Get number of incidents and average arrival time by year
Select Month_Year, COUNT(*) As Count, AVG(Arrival_minutes) As Arrival_time From SF_Fires..Fire_Incidents
Group By Month_Year

-- Number of incidents per month for each neighborhood
Select Month_Year, neighborhood_district, COUNT(*) As Count From SF_Fires..Fire_Incidents
Where NOT neighborhood_district = 'NULL'
Group By Month_Year, neighborhood_district 

-- Fix city strings
Update SF_Fires..Fire_Incidents
Set City = REPLACE(City, 'SF','San Francisco')
Update SF_Fires..Fire_Incidents
Set City = REPLACE(City, 'SAN FRANCISCO', 'San Francisco')
Update SF_Fires..Fire_Incidents
Set City = REPLACE(City, 'DC', 'Daly City')
Update SF_Fires..Fire_Incidents
Set City = REPLACE(City, 'San FranciscoO', 'San Francisco')
Update SF_Fires..Fire_Incidents
Set City = REPLACE(City, 'TI', 'Treasure Island')
Update SF_Fires..Fire_Incidents
Set City = REPLACE(City, 'YB', 'Yerba Buena')
Update SF_Fires..Fire_Incidents
Set City = REPLACE(City, 'PR', 'Presidio')
Update SF_Fires..Fire_Incidents
Set City = REPLACE(City, 'HP', 'Hunters Point')
Update SF_Fires..Fire_Incidents
Set City = REPLACE(City, 'FM', 'Fort Mason')
Update SF_Fires..Fire_Incidents
Set City = REPLACE(City, 'BN', 'Brisbane')

-- Number of fire violations per ZIP code
Select Zipcode, COUNT(*) As Violation_Count From SF_Fires..Fire_Violations
Group By Zipcode

-- Number of incidents and average arrival time per ZIP code
Select Fire_Incidents.zipcode, City, COUNT(*) As Incident_Count, AVG(Arrival_minutes) As Arrival_Time From SF_Fires..Fire_Incidents
Where zipcode IS NOT NULL
Group By Fire_Incidents.zipcode, City

-- Remove dashes from "Property Use" column
Update SF_Fires..Fire_Incidents
Set [Property Use] = REPLACE([Property Use], '-', '') From SF_Fires..Fire_Incidents

-- Add new column and get the property code from the "Property Use" column
Alter Table SF_Fires..Fire_Incidents
Add property_code nvarchar(255)
Update SF_Fires..Fire_Incidents
Set property_code = SUBSTRING([Property Use], 1, 3)

-- Add new column and get the "primary situation" code from the "primary situation" column
Alter Table SF_Fires..Fire_Incidents
Add situation_code nvarchar(255)
Update SF_Fires..Fire_Incidents
Set situation_code = SUBSTRING([Primary Situation], 1, 3)

-- Add new column and get the "Area of Fire Origin" code from the "Area of Fire Origin" column
Alter Table SF_Fires..Fire_Incidents
Add origin_code nvarchar(255)
Update SF_Fires..Fire_Incidents
Set origin_code = SUBSTRING([Area of Fire Origin], 1, 3)

-- Count occurances of incidents by origin area
Select [origin_code], COUNT(*) As origin_count From SF_Fires..Fire_Incidents Group By [origin_code]
Order By origin_count
