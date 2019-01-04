% Procedures
% Topic retirever
proc topicRetriever
    % Get the topic requested
    loop
        locatexy (233, 380)
        get topicChoice : *
        for j : 1 .. length(topicChoice)
            if topicChoice(1) = " " or length(topicChoice) > 14
                then
                loop
                    % Overwrites the previous text so the user can retype if they woud like to
                    Pic.ScreenLoad (ENTER_SPACE, 226, 360, picCopy)
                    locatexy (233, 380)
                    get topicChoice : *
                    exit when topicChoice(1) not = " "
                end loop
            else
                exit
            end if
        end for
            exit when length(topicChoice) > 0 and length(topicChoice) <= 14
    end loop
end topicRetriever

% Word retriever
proc wordRetriever
    % Loop to allow user to input what word they want
    loop
        % Resets the word choices
        iWordChoice := ""
        wordChoice := ""
        locatexy (233, 200)
        get iWordChoice : *
        for j : 1 .. length(iWordChoice)
            if iWordChoice(1) = " " or length(iWordChoice) > 16
                then
                loop
                    % Overwrites the previous text so the user can retype if they would like to
                    iWordChoice := ""
                    Pic.ScreenLoad (ENTER_SPACE, 226, 183, picCopy)
                    locatexy (233, 200)
                    get iWordChoice : *
                    exit when iWordChoice(1) not = " "
                end loop
            else
                exit
            end if
        end for
            exit when length(iWordChoice) > 0 and length(iWordChoice) <= 16
    end loop    
    % Swaps the entire sentence's letters in uppercase
    for i : 1 .. length(iWordChoice)
        % If the letter is lower case then swaps to upper case
        if ord(iWordChoice(i)) <= 122 and ord(iWordChoice(i)) >= 97
            then
            asciiCode := ord(iWordChoice(i)) - 32
            wordChoice += chr(asciiCode)
            % If the lette1r is not lower case, it ignores the letter
        else
            asciiCode := ord(iWordChoice(i))
            wordChoice += chr(asciiCode)
        end if
    end for  
end wordRetriever


% Function to check if the user entered anything other than numbers
fcn getIntLvl (): int
    var input : string
    % Loops retreiving of the input
    loop
        % Takes the input from the user
        locatexy (DIFF_X, DIFF_Y)
        get input : *
        % Exits when a string is read
        exit when strintok (input)
        % Refreshes the location to input level choice
        Pic.ScreenLoad (LVL_SPACE, LVL_SPACE_X, LVL_SPACE_Y, picCopy)
    end loop
    % Gives the result of the function
    result (strint (input))
end getIntLvl

% Allows user to choose the difficulty in which it selects the hangman according to the statements of the getHangman procedure
proc diffRetriever
    % Gets the difficulty
    diff := getIntLvl ()
    loop
        if diff > 3 or diff < 1
            then
            Pic.ScreenLoad (LVL_SPACE, LVL_SPACE_X, LVL_SPACE_Y, picCopy)
            locatexy (DIFF_X, DIFF_Y)
            diff := getIntLvl ()
        end if
        exit when diff <= 3 and diff > 0
    end loop
    % Easiest difficulty
    if diff = 1
        then
        % Sets the life count according to difficulty
        life := DIFF_1_LIFE
        % Searches the image files for the hangman and stores it in an array for the first difficulty
        loop
            new diffArray, upper(diffArray) + 1
            diffArray(upper(diffArray)) := "images/gameScreen/" + hangChar + "Char/" + imgC + "i" + intstr(upper(diffArray)) + ".jpg"
            exit when upper(diffArray) = DIFF_1_LIFE
        end loop
        % Medium difficulty
    elsif diff = 2
        then
        % Sets the life count according to difficulty
        life := DIFF_2_LIFE
        % Searches the image files for the hangman and stores it in an array for the second difficulty
        loop
            new diffArray, upper(diffArray) + 1
            diffArray(upper(diffArray)) := "images/gameScreen/" + hangChar + "Char/" + imgC + "ii" + intstr(upper(diffArray)) + ".jpg"
            exit when upper(diffArray) = DIFF_2_LIFE
        end loop
        % Hardest difficulty
    elsif diff = 3
        then
        % Sets the life count according to difficulty
        life := DIFF_3_LIFE
        % Searches the image files for the hangman and stores it in an array for the third difficulty
        loop
            new diffArray, upper(diffArray) + 1
            diffArray(upper(diffArray)) := "images/gameScreen/" + hangChar + "Char/" + imgC + "iii" + intstr(upper(diffArray)) + ".jpg"
            exit when upper(diffArray) = DIFF_3_LIFE
        end loop
    end if
end diffRetriever

% Converts letter to capitals
proc convLetter
    % Resets the letter choice
    letterChoice := ""
    % Letter swap from lower case to upper case
    for i : 1 .. length(iLetterChoice)
        % If the letter is lower case then swaps to upper case
        if ord(iLetterChoice(i)) <= 122 and ord(iLetterChoice(i)) >= 97
            then
            asciiCode := ord(iLetterChoice(i)) - 32
            letterChoice += chr(asciiCode)
            % If it is not lower case, it ignores the letter
        else
            asciiCode := ord(iLetterChoice(i))
            letterChoice += chr(asciiCode)
        end if
    end for
end convLetter

% Resets the game values to allow user to replay the game
proc gameReset
    % Sets the variables back to default settings
    emptWord := ""
    storedLet := ""
    wordC := 1
    lifeC := 0
    picC := 0
    c := 0
    % Erases the contents in the flexible arrays
    new letArray, 0
    new diffArray, 0
end gameReset

% Radio button for the characters
procedure charPressed
    % Different click sound when pressing the radio buttons
    fork click2
    
    % Goes through the array of the numbers
    for i : 1 .. upper(charChoice)
        % Dat boi selection
        if charChoice (1) = GUI.GetEventWidgetID
            then
            % Sets variables to allow the diffRetriever to retrieve images based on user selectoin
            hangChoice := 1
            hangChar := DAT_BOI_CHAR
            imgC := DATBOI_IMGC
        elsif charChoice (2) = GUI.GetEventWidgetID
            then
            % Sets variables to allow the diffRetriever to retrieve images based on user selectoin
            hangChoice := 2
            hangChar := SPONGE_GAR_CHAR
            imgC := SPONGE_IMGC
        end if
    end for
end charPressed