% Buttons handle button events

% Quit intro window button
proc quitIntroWindowButtonPressed
    fork click
    isIntroWindowOpen := false
    GUI.Quit
    GUI.ResetQuit
end quitIntroWindowButtonPressed

% Quit instruction window button 
proc quitInstructWindowButtonPressed
    fork click
    isInstructWindowOpen := false
    GUI.Quit
    GUI.ResetQuit
end quitInstructWindowButtonPressed

% Quit game window button 
proc quitGameWindowButtonPressed
    fork click
    isGameWindowOpen := false
    GUI.Quit
    GUI.ResetQuit
end quitGameWindowButtonPressed

% Quit topic and word window button
proc quitTopicWordWindowButtonPressed
    fork click
    isTopicWordWindowOpen := false
    GUI.Quit
    GUI.ResetQuit
end quitTopicWordWindowButtonPressed

% Quit hangman window button 
proc quitHangmanButtonPressed
    fork click
    isHangmanWindowOpen := false
    GUI.Quit
    GUI.ResetQuit
end quitHangmanButtonPressed

% Quit credits button 
proc quitCreditsButtonPressed
    fork click
    isCreditsWindowOpen := false
    GUI.Quit
    GUI.ResetQuit
end quitCreditsButtonPressed



