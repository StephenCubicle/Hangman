% Displays the hangman selection window
proc displayHangmanWindow
    % Sets up the screen with resolution and background
    var winHangmanID : int
    const HANGMAN_IMG : string := "images/backgrounds/hangmanBG.jpg"
    winHangmanID := Window.Open ("position:center;center,graphics:800;600,title:Hangman Window")
    isHangmanWindowOpen := true
    Pic.ScreenLoad(HANGMAN_IMG, BG_X_Y, BG_X_Y, picCopy)
    
    % Sound of a click when window opens
    fork click
    
    % Radio buttons to allow user to select which character they want
    charChoice (1) := GUI.CreateRadioButton (250, 190, "Dat Boi", 0, charPressed)
    charChoice (2) := GUI.CreateRadioButton (460, 190, "SpongeGar", charChoice(1), charPressed)
    
    % Button to end the screen
    var backButton := GUI.CreatePictureButton (348, 108, BACK_IMG, quitHangmanButtonPressed)
    loop
        exit when GUI.ProcessEvent or isHangmanWindowOpen = false
    end loop
    Window.Hide (winHangmanID)
end displayHangmanWindow
