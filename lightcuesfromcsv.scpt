-- imports the qlablightingcue csv file in that format into qlab
-- for each q number in the file will be inported as a network que. if there is a x.x number then it will be created as a group

-- configs
set scriptPath to (path to me)
set scriptFolder to (container of scriptPath) as alias
set csvFilePath to (scriptFolder as text) & "qlablightingcue.csv"
set myCuelistName to "Lighting Imported"
set csvSeparator to ","

-- read file
set csvLines to every paragraph of (read file csvFilePath)

-- tell qlab
tell application id "com.figure53.QLab.5" to tell front workspace
	set current cue list to myCuelistName
	set currentGroup to missing value
	set lineIndex to 0
	repeat with currentLineRaw in csvLines
		set lineIndex to lineIndex + 1
		if lineIndex is 1 then
			continue repeat
		end if

		-- Note: null removal commented out for clean input
		-- set AppleScript's text item delimiters to AppleScript's character id (0)
		-- set tempArr to (every text item of currentLineRaw)
		-- set AppleScript's text item delimiters to ""
		-- set currentLine to tempArr as text
		set currentLine to currentLineRaw

		-- split the line into an array on the comma separator
		set AppleScript's text item delimiters to csvSeparator
		set csvFields to every text item of currentLine
		set AppleScript's text item delimiters to linefeed

		-- load the current values
		set qlabQText to (item 1 of csvFields) as text
		set qlabName to (item 2 of csvFields) as text
		set eosQText to (item 3 of csvFields) as text
		set eosName to (item 4 of csvFields) as text

		-- Determine if this is a new group (has decimal point)
		set hasDecimal to (qlabQText contains ".")
		set digitBeforeDecimal to missing value
		
		if hasDecimal then
			set AppleScript's text item delimiters to "."
			set digitBeforeDecimal to text item 1 of qlabQText
			set AppleScript's text item delimiters to linefeed
			
			-- Check if we need a new group
			if currentGroup is missing value or digitBeforeDecimal is not equal to currentGroup then
				make type "group"
				set currentGroup to (last item of (selected as list))
				set q name of currentGroup to "Group " & digitBeforeDecimal
			end if
		end if
		
		-- Create the Network cue
		make type "Network"
		set networkCue to last item of (selected as list)
		set qlabQNumber to (qlabQText as number)
		set q number of networkCue to qlabQNumber
		set q name of networkCue to qlabName
		set network patch number of networkCue to 2
		set parameter values of networkCue to {"cue", "no", "fire", eosQText} 
		
		-- Move to group if needed
		if hasDecimal and currentGroup is not missing value then
			set parent of networkCue to currentGroup
		end if
	end repeat
end tell