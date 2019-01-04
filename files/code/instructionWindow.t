% Displays the instruction window
proc displayInstructionWindow
    % Sets up the screen with resolution and background
    var winInstructID : int
    const INSTRUCT_IMG : string := "images/backgrounds/instructionsBG.jpg"
    winInstructID := Window.Open ("position:center;center,graphics:800;600,title:Instruction Window")
    isInstructWindowOpen := true
    Pic.ScreenLoad(INSTRUCT_IMG, BG_X_Y, BG_X_Y, picCopy)
    
    % Sound of a click when window opens
    fork click
    
    % Button to end the screen
    var backButton := GUI.CreatePictureButton (348, 108, BACK_IMG, quitInstructWindowButtonPressed)
    loop
        exit when GUI.ProcessEvent or isInstructWindowOpen = false
    end loop
    Window.Hide (winInstructID)
end displayInstructionWindow
