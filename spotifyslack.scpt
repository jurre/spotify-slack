tell application "Spotify"
  set current_track to null
  set current_artist to null

  set slack_token to system attribute "SLACK_TOKEN"

  repeat until application "Spotify" is not running
    set track_name to name of current track
    set track_artist to artist of current track

    if track_name ≠ current_track
      set current_track to name of current track
      set current_artist to artist of current track
      set current_album to album of current track

      set message to "NP: " & current_artist & " - " & current_track

      -- Strip & and ' characters
      set message to do shell script "echo \"" & message & "\" | sed \"s/'//g\" | sed 's/&/and/g'"

      set payload to "{\"status_text\": \"" & message & "\", \"status_emoji\": \":headphones:\"}"
      do shell script "curl -sS -d 'token=" & slack_token & "&profile=" & payload & "' https://slack.com/api/users.profile.set"
    end if

    delay 15
  end repeat
end tell
