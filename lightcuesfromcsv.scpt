-- imports the qlablightingcue csv file in that format into qlab
-- for each q number in the file will be inported as a network que. if there is a x.x number then it will be created as a group

-- configs
set myfile to qlablightingcue.csv
set myCuelistName to "Lighting Imported"

-- read file
set myArray to every paragraph of (read file myfile)
set AppleScript's text item delimiters to sep

-- tell qlab
tell application id "com.figure53.QLab.5" to tell front workspace
	set current cue list to myCuelistName
	set results to {}
	set group to {}
	repeat with myline1 in myArray

		------- kludge to remove nulls from string split the line on nulls to remove them
		set AppleScript's text item delimiters to AppleScript's character id (0)
		set tempArr to (every text item of myline1)
		-- then rejoin the string without them
		set AppleScript's text item delimiters to ""
		set myline to tempArr as text
		---------------- end of kludge ------------

		-- split the line into an array on the comma separator
		set AppleScript's text item delimiters to sep
		set myitems to every text item of myline
		set AppleScript's text item delimiters to linefeed

		-- load the current value
		set qlabq to (item 1 of myitems) as number
		set qlabname to (item 2 of myitems) as text
		set eosq to (item 3 of myitems) as text
		set eosname to (item 4 of myitems) as text

		if qlabqText does not contain "." then
			make type "Network" 
			set networkCue to last item of (selected as list)
			set q number of networkCue to qlabq
			set q name of networkCue to qlabname
			set network patch number of networkCue to 2
			set parameter values of networkCue to {"cue", "no", "fire", eosq} 

		else
			-- has decimal, extract digit before decimal
			set AppleScript's text item delimiters to "."
			set digitBeforeDec to text item 1 of qlabqText
			set AppleScript's text item delimiters to linefeed
			
			if digitBeforeDec = group then
				make type "Network" 
				set networkCue to last item of (selected as list)
				set q number of networkCue to qlabq
				set q name of networkCue to qlabname
				set network patch number of networkCue to 2
				set parameter values of networkCue to {"cue", "no", "fire", eosq} 
				move networkCue to end of GroupCue
			else
				set group to digitBeforeDec
				-- create group
				make type "group"
				set GroupCue to last item of (selected as list)
				set group to digitBeforeDec
				-- create cue
				make type "Network" 
				set networkCue to last item of (selected as list)
				set q number of networkCue to qlabq
				set q name of networkCue to qlabname
				set network patch number of networkCue to 2
				set parameter values of networkCue to {"cue", "no", "fire", eosq} 
				move networkCue to end of GroupCue
			end if
		end if
	end repeat
end tell