% Displays the credits window
proc displayCreditsWindow
    % Sets up the screen with resolution and background
    var winCreditsID : int
    const CREDITS_IMG : string := "images/backgrounds/creditsBG.jpg"
    winCreditsID := Window.Open ("position:center;center,graphics:800;600,title:Credits Window")
    isCreditsWindowOpen := true
    Pic.ScreenLoad(CREDITS_IMG, BG_X_Y, BG_X_Y, picCopy)
    
    % Sound of a click when window opens
    fork click
    
    % Button to end the screen
    var backButton := GUI.CreatePictureButton (610, 90, BACK_IMG, quitCreditsButtonPressed)
    loop
        exit when GUI.ProcessEvent or isCreditsWindowOpen = false
    end loop
    Window.Hide (winCreditsID)
end displayCreditsWindow