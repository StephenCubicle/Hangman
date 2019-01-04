% Displays the introduction window
proc displayIntroWindow
    % Image declaration
    const BG_IMG : string := "images/backgrounds/introBG.jpg"
    const INSTRUCT_IMG := Pic.FileNew("images/buttons/instructions.jpg")
    const START_IMG := Pic.FileNew("images/buttons/playGame.jpg")
    const CHOOSE_WORD_AND_TOPIC_IMG := Pic.FileNew("images/buttons/chooseTopicAndWord.jpg")
    const CHOOSE_HANGMAN := Pic.FileNew("images/buttons/chooseHangman.jpg")
    const QUIT_IMG := Pic.FileNew("images/buttons/quit.jpg")
    const CREDITS_IMG := Pic.FileNew("images/buttons/credits.jpg")
    
    % Sets up the screen with resolution and background
    var winIntroID : int
    winIntroID := Window.Open ("position:center;center,graphics:800;600,title:Introduction Window")
    Pic.ScreenLoad(BG_IMG, BG_X_Y, BG_X_Y, picCopy)
    isIntroWindowOpen := true
    
    % Forks the hangman title
    fork hangmanTitle
    
    % Forks the intro music
    fork introMusic
    
    % Play game button
    var startButton := GUI.CreatePictureButton (517, 343, START_IMG, displayGameWindow)
    % Instruction button
    var instructionsButton := GUI.CreatePictureButton (569, 287, INSTRUCT_IMG, displayInstructionWindow)
    % Choose topic and word button
    var chooseTopicAndWordButton := GUI.CreatePictureButton (569, 233, CHOOSE_WORD_AND_TOPIC_IMG, displayTopicWordWindow)
    % Hangman selection button
    var chooseHangmanButton := GUI.CreatePictureButton (569, 178, CHOOSE_HANGMAN, displayHangmanWindow)
    % Credits button
    var creditsButton := GUI.CreatePictureButton (115, 20, CREDITS_IMG, displayCreditsWindow)
    % Quit button
    var quitButton := GUI.CreatePictureButton (20, 20, QUIT_IMG, quitIntroWindowButtonPressed)
    
    
    % Exits the game entirely when the quit button is pressed
    loop
        exit when GUI.ProcessEvent or isIntroWindowOpen = false
    end loop
    
    % Makes a click sound when the game closes
    fork click
    delay(CLICK_DELAY)
    
    % Ends all game music
    Music.PlayFileStop
    
    Window.Hide (winIntroID)
end displayIntroWindow
