% Display topic word window
proc displayTopicWordWindow
    % Sets up the screen with resolution and background
    const TOPIC_WORD_IMG : string := "images/backgrounds/topicWordBG.jpg"
    var winTopicWordID : int
    winTopicWordID := Window.Open ("position:center;center,graphics:800;600,title:Topic and Word Window")
    Pic.ScreenLoad(TOPIC_WORD_IMG, 0, 0, picCopy)
    isTopicWordWindowOpen := true
    
    % Sound of a click when window opens
    fork click
    
    % Calls the topic retriever procedure
    topicRetriever
    
    % Calls the word retriever procedure
    wordRetriever
    
    % Button to end the screen
    var backButton := GUI.CreatePictureButton (348, 108, BACK_IMG, quitTopicWordWindowButtonPressed)
    loop
        exit when GUI.ProcessEvent or isTopicWordWindowOpen = false
    end loop
    Window.Hide (winTopicWordID)
end displayTopicWordWindow