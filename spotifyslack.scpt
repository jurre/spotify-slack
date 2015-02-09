tell application "Spotify"
  set current_track to null
  set current_artist to null
  set current_album to null

  set slack_token to "your token"
  set slack_channel to "your channel"
  set slack_username to "your name"

  repeat until application "Spotify" is not running
    set track_name to name of current track
    set track_artist to artist of current track
    set track_album to album of current track

    if track_name ≠ current_track and track_artist ≠ current_artist and track_album ≠ current_track then
      set current_track to name of current track
      set current_artist to artist of current track
      set current_album to album of current track

      set message to "#NP: " & current_artist & " -  " & current_track

      do shell script "curl -sS -d 'token=" & slack_token & "&channel=" & slack_channel & "&username=" & slack_username & "&text=" & message & "' https://slack.com/api/chat.postMessage"

    end if

    delay 5
  end repeat
end tell
