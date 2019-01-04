% Displays the hangman game
proc displayGameWindow
    % Variable declaration
    % Fonts
    const font := Font.New ("calibri:15")
    const font2 := Font.New ("calibri:14")
    const font3 := Font.New ("calibri:12")
    % End of fonts
    % Image declaration
    const CHOOSE_SPACE : string := "images/gameScreen/layoutCoverUps/spaceLet.jpg"
    const GUESS_SPACE : string := "images/gameScreen/layoutCoverUps/guessSpace.jpg"
    const LIVES_IMG : string := "images/gameScreen/layoutCoverUps/livesSpace.jpg"
    const BG_IMG : string := "images/backgrounds/gameBG.jpg"
    const WIN_IMG : string := "images/backgrounds/winBG.jpg"
    const LOSE_IMG : string := "images/backgrounds/loseBG.jpg"
    const LVL_IMG : string := "images/backgrounds/lvlBG.jpg"
    const FIX_IMG : string := "images/backgrounds/enterFirstBG.jpg"
    const WIN_LOSE_SPACE : string := "images/gameScreen/layoutCoverUps/loseWinSpace.jpg"
    const UND_SCORE : string := "_"
    const SPACE : string := " "
    % End of image declaration
    % Start of image locations
    const HEAD_X : int := 171
    const HEAD_Y : int := 376
    const BODY_X : int := 197
    const BODY_Y : int := 301
    const LEFT_ARM_X : int := 159
    const LEFT_ARM_Y : int := 312
    const RIGHT_ARM_X : int := 231
    const RIGHT_ARM_Y : int := 315
    const LEFT_LEG_X : int := 165
    const LEFT_LEG_Y : int := 248
    const RIGHT_LEG_X : int := 214
    const RIGHT_LEG_Y : int := 250
    const BOTH_LEGS_X_OR_FULL : int := 162
    const BOTH_LEGS_Y_OR_FULL : int := 248
    % End of image locations
    % Start of refresh images so new text can appear on the selected area
    const SPACE_X : int := 471
    const SPACE_Y : int := 142
    const LOSE_WIN_SPACE_X : int := 249
    const LOSE_WIN_SPACE_Y : int := 196
    const END_WORD_X: int := 256
    const END_WORD_Y: int := 208
    % End of refresh images so new text can appear on the selected area
    const DELAY_END : int := 1000
    var flexWordC, wordShow : string
    var ignWord : string := ""
    var letPos, wordLength : int
    
    % Sets the window size and sets it as a separate screen
    var winGameID : int 
    winGameID := Window.Open ("position:center;center,graphics:800;600,title:Game Window")
    isGameWindowOpen := true
    
    % Initialzies the array with spaces
    for a : 1 .. upper(letArray)
        letArray(a) := SPACE
    end for
        
    % Makes a click sound 
    fork click
    
    % To ensure users do not press play game until they actually typed a word and topic
    if iWordChoice = ">>>>GAME_WON'T_WORK_UNTIL_YOU_TYPE_SOMETHING_OTHER_THAN_THIS<<<<" or topicChoice = ">>>>GAME_WON'T_WORK_UNTIL_YOU_TYPE_SOMETHING_OTHER_THAN_THIS<<<<"
        then
        %
        Pic.ScreenLoad (FIX_IMG, BG_X_Y, BG_X_Y, picCopy)
        var backButton := GUI.CreatePictureButton (610, 90, BACK_IMG, quitGameWindowButtonPressed)
        loop
            exit when GUI.ProcessEvent or isGameWindowOpen = false
        end loop
        
        GUI.CloseWindow (winGameID)
        % Prematurely exits the procedure
        return
    end if
    
    % Forks the game music
    fork gameMusic
    
    % Initializes the flexible word that is used to determine when the user sucessfully guesses the word(s)
    flexWordC := wordChoice
    % Initializes a word to sub in an asterik for spaces
    ignWord := wordChoice
    Pic.ScreenLoad(LVL_IMG, BG_X_Y, BG_X_Y, picCopy)
    
    % Get the amount of lives
    diffRetriever
    
    % Clears the screen
    cls
    Pic.ScreenLoad(BG_IMG, BG_X_Y, BG_X_Y, picCopy)
    
    % Stores the empty word with underscores
    for i : 1 .. length(wordChoice)
        emptWord += UND_SCORE
    end for
        
    % Initializes the word that is shown on the screen to the empty word
    wordShow := emptWord
    
    % Loop to check make the debugging word's spaces asterisks instead and add spaces to the word shown on the screen and the empty word
    loop
        if index(ignWord, SPACE) > 0
            then
            % Stores the position of the letter
            letPos := index(ignWord, SPACE)
            ignWord := ignWord(1 .. letPos - 1) + "." + ignWord(letPos + 1 .. *)
            emptWord := emptWord(1 .. letPos - 1) + SPACE + emptWord(letPos + 1 .. *)
            wordShow := wordShow(1 .. letPos - 1) + "/" + wordShow(letPos + 1 .. *)
            wordC += 1
        end if
        % Exits when there are no more spaces
        exit when index(ignWord, SPACE) = 0
    end loop
    
    % If the counter is 1 
    if wordC = 1
        then
        % Word is the length accordingly
        wordLength := length(wordShow)
    else
        % Length of word(s) is the length of the word(s) subratcted by the amount of words plus one
        wordLength := length(wordShow) -wordC + 1
    end if
    
    % Puts the topic and lives left on the screen
    Font.Draw (topicChoice, 520, 490, font, 1)
    Font.Draw (intstr(wordC), 400, 275, font, 1)
    Font.Draw (intstr(wordLength), 460, 301, font, 1)
    Font.Draw (wordShow, 345, 425, font, 50)
    Font.Draw (intstr(life), 732, 542, font3, 1)
    
    
    % Loop to check if the requested letters are actually in the word
    loop
        % Gets the letter requested (can be numbers or anything string text)
        locatexy (480, 170)
        get iLetterChoice :*
        % Converts the letter to uppercase if not already 
        convLetter
        Pic.ScreenLoad(CHOOSE_SPACE, SPACE_X, SPACE_Y, picCopy)
        
        % If the user chooses more than one letter
        loop
            % Tells the user that they cannot request more than one letter
            if length(letterChoice) > 1 or letterChoice = ""
                then
                Font.Draw ("Enter one letter only.", 480, 145, font, 1)
                % Gets the letter
                locatexy (480, 170)
                get iLetterChoice : *
                convLetter
                Pic.ScreenLoad(CHOOSE_SPACE, SPACE_X, SPACE_Y, picCopy)
            end if
            % Exits when the length of the letter is only one
            exit when length(letterChoice) = 1
        end loop
        
        % Loop to swap the words
        loop
            % Checks if the letter was already chosen
            if index(storedLet, letterChoice) > 0
                then
                Font.Draw ("Already selected!", 480, 145, font, 1)  
                % If the letter is not already chosen, then the user loses a life
            elsif index(flexWordC, letterChoice) = 0
                then
                % Shows where the counter is at the moment
                lifeC += 1
                % Life lost
                life -= 1
                % If the difficulty is 1, then the program takes all the images corresponding to which character was chosen
                if diff = 1
                    then
                    % Head
                    if life = DIFF_1_LIFE - 1
                        then
                        Pic.ScreenLoad (diffArray(lifeC), HEAD_X, HEAD_Y, picCopy)
                        % Body
                    elsif life = DIFF_1_LIFE - 2
                        then
                        Pic.ScreenLoad (diffArray(lifeC), BODY_X, BODY_Y, picCopy)
                        % Left Arm
                    elsif life = DIFF_1_LIFE - 3
                        then
                        Pic.ScreenLoad (diffArray(lifeC), LEFT_ARM_X, LEFT_ARM_Y, picCopy)
                        % Right Arm
                    elsif life = DIFF_1_LIFE - 4
                        then
                        Pic.ScreenLoad (diffArray(lifeC), RIGHT_ARM_X, RIGHT_ARM_Y, picCopy)
                        % Left Leg
                    elsif life = DIFF_1_LIFE - 5
                        then
                        Pic.ScreenLoad (diffArray(lifeC), LEFT_LEG_X, LEFT_LEG_Y, picCopy)
                        % Right Leg
                    elsif life = DIFF_1_LIFE - 6
                        then
                        Pic.ScreenLoad (diffArray(lifeC), RIGHT_LEG_X, RIGHT_LEG_Y, picCopy)
                        % Final Touch
                    elsif life = DIFF_1_LIFE - 7
                        then
                        % Dat boi's eye
                        if hangChoice = 1
                            then
                            Pic.ScreenLoad (diffArray(lifeC), HEAD_X, HEAD_Y, picCopy)
                            % Spongegar's tie
                        elsif hangChoice = 2
                            then
                            Pic.ScreenLoad (diffArray(lifeC), BODY_X, BODY_Y, picCopy)
                        end if
                    end if
                    % If the difficulty is 2, then the program takes all the images corresponding to which character was chosen
                elsif diff = 2
                    then
                    % Head
                    if life = DIFF_2_LIFE - 1
                        then
                        Pic.ScreenLoad (diffArray(lifeC), HEAD_X, HEAD_Y, picCopy)
                        % Body
                    elsif life = DIFF_2_LIFE - 2
                        then
                        Pic.ScreenLoad (diffArray(lifeC), BODY_X, BODY_Y, picCopy)
                        % Left Arm
                    elsif life = DIFF_2_LIFE - 3
                        then
                        Pic.ScreenLoad (diffArray(lifeC), LEFT_ARM_X, LEFT_ARM_Y, picCopy)
                        % Right Arm
                    elsif life = DIFF_2_LIFE - 4
                        then
                        Pic.ScreenLoad (diffArray(lifeC), RIGHT_ARM_X, RIGHT_ARM_Y, picCopy)
                        % Both Legs
                    elsif life = DIFF_2_LIFE - 5
                        then
                        Pic.ScreenLoad (diffArray(lifeC), BOTH_LEGS_X_OR_FULL, BOTH_LEGS_Y_OR_FULL, picCopy)
                    end if
                    % If the difficulty is 3, then the program takes all the images corresponding to which character was chosen
                elsif diff = 3
                    then
                    % Head
                    if life = DIFF_3_LIFE - 1
                        then
                        Pic.ScreenLoad (diffArray(lifeC), HEAD_X, HEAD_Y, picCopy)
                        % Full body
                    elsif life = DIFF_3_LIFE - 2
                        then
                        Pic.ScreenLoad (diffArray(lifeC), BOTH_LEGS_X_OR_FULL, BOTH_LEGS_Y_OR_FULL, picCopy)
                    end if
                end if
                % If the letter is in the flexible word
            elsif index(flexWordC, letterChoice) > 0
                then
                % Stores the position of the letter
                letPos := index(flexWordC, letterChoice)
                % Changes the empty space in the location of the letter and places the letter there
                wordShow := wordShow(1 .. letPos - 1) + letterChoice + wordShow(letPos + 1 .. *)
                % Changes the letter within the flexible word to an underscore
                flexWordC := flexWordC(1 .. letPos - 1) + UND_SCORE + flexWordC(letPos + 1 .. *)
            end if
            % Exits when the letter requested is no longer in the word(s)
            exit when index(flexWordC, letterChoice) = 0 or index(storedLet, letterChoice) > 0
        end loop
        
        % If the letter is in the stored letters
        if index (storedLet, letterChoice) = 0
            then
            % Adds a new row for the flexible array to store the letters chosen
            new letArray, upper(letArray) + 1
            letArray(upper(letArray)) := letterChoice
            % To add the stored letters into the stored letters that are to be shown on the screen
            storedLet += letArray(upper(letArray)) + " "
        end if
        
        % Puts the letters that are in the word on the screen along with the underscores
        Pic.ScreenLoad(GUESS_SPACE, 315, 321, picCopy)
        Pic.ScreenLoad(LIVES_IMG, 654, 534, picCopy)
        Font.Draw (wordShow, 345, 425, font, 50)
        Font.Draw(storedLet, 332, 350, font2, 8)
        Font.Draw (intstr(life), 732, 542, font3, 1)
        
        % If the flexible word equals the empty word then the user wins
        if flexWordC = emptWord
            then
            % Forks the intro music when exitting this screen
            fork winMusic
            delay(DELAY_END)
            cls
            % Loads the word chosen space to replace the previous text
            Pic.ScreenLoad (WIN_IMG, BG_X_Y, BG_X_Y, picCopy)
            Pic.ScreenLoad (WIN_LOSE_SPACE, LOSE_WIN_SPACE_X, LOSE_WIN_SPACE_Y, picCopy)
            Font.Draw (wordChoice, END_WORD_X, END_WORD_Y, font, 1)
            % A button to end the game
            var backButton := GUI.CreatePictureButton (70, 70, BACK_IMG, quitGameWindowButtonPressed)
            gameReset
            loop
                exit when GUI.ProcessEvent or isGameWindowOpen = false
            end loop
            % Forks the intro music when exitting this screen
            fork introMusic
            exit
            % If the amount of lives left equal 0, then the user loses
            
        elsif life = 0
            then
            % Forks the intro music when exitting this screen
            fork loseMusic
            delay(DELAY_END)
            cls
            
            % Loads the word chosen space to replace the previous text
            Pic.ScreenLoad (LOSE_IMG, BG_X_Y , BG_X_Y, picCopy)
            Pic.ScreenLoad (WIN_LOSE_SPACE, LOSE_WIN_SPACE_X, LOSE_WIN_SPACE_Y, picCopy)
            Font.Draw (wordChoice, END_WORD_X, END_WORD_Y, font, 1)
            
            % A button to end tehe game
            var backButton := GUI.CreatePictureButton (70, 70, BACK_IMG, quitGameWindowButtonPressed)
            gameReset
            loop
                exit when GUI.ProcessEvent or isGameWindowOpen = false
            end loop
            % Forrks the intro music when exitting this screen
            fork introMusic
            exit
        end if
    end loop
    Window.Hide (winGameID)
end displayGameWindow