-- Creates QLab Network cues from lightingcues.csv in this folder.

set scriptPath to (path to me)
set scriptFolder to (container of scriptPath) as alias
set csvFile to (scriptFolder as text) & "lightingcues.csv"

set csvText to read file csvFile
set oldDelims to AppleScript's text item delimiters
set AppleScript's text item delimiters to linefeed
set csvLines to text items of csvText
set AppleScript's text item delimiters to oldDelims

if (count of csvLines) is 0 then return

-- Skip header row.
set startIndex to 2

-- Helper to trim whitespace.
on trimText(t)
	set whiteSpace to {space, tab, return, linefeed}
	set oldDelims to AppleScript's text item delimiters
	set AppleScript's text item delimiters to whiteSpace
	set itemsList to text items of t
	set AppleScript's text item delimiters to ""
	set t to itemsList as text
	set AppleScript's text item delimiters to oldDelims
	return t
end trimText

repeat with i from startIndex to (count of csvLines)
	set lineText to item i of csvLines
	if lineText is "" then
		-- Skip blank lines.
		continue repeat
	end if

	set oldDelims to AppleScript's text item delimiters
	set AppleScript's text item delimiters to ","
	set cols to text items of lineText
	set AppleScript's text item delimiters to oldDelims

	if (count of cols) < 2 then
		-- Not enough columns to read Q and Name.
		continue repeat
	end if

	set cueQ to my trimText(item 1 of cols)
	set cueName to my trimText(item 2 of cols)

	if cueQ is "" then
		-- Skip rows without a cue number.
		continue repeat
	end if

	set fullName to cueQ
	if cueName is not "" then
		set fullName to cueQ & " " & cueName
	end if

	tell application id "com.figure53.QLab.5" to tell front workspace
		make type "Network"
		set networkCue to last item of (selected as list)	
		set q name of networkCue to fullName
		set network patch number of networkCue to 2
		set custom message of networkCue to "/eos/cue/" & cueQ & "/fire/"
	end tell
end repeat
