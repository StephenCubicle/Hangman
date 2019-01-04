% Displays the hangman title in the intro screen
process hangmanTitle
    % Variable declaration
    const TITLE : string := "images/titleFlash/t"
    const JPG : string := ".jpg"
    % Number of images in the folder
    const NUM_IMG : int := 7
    const DELAY : int := 80
    % Location of the title
    const TITLE_X : int := 348
    const TITLE_Y : int := 411
    
    % Constantly loops the images
    loop
        for i : 1 .. NUM_IMG
            Pic.ScreenLoad (TITLE + intstr(i) + JPG, TITLE_X, TITLE_Y, picCopy)
            delay(DELAY)
        end for
    end loop
end hangmanTitle

% Intro music
process introMusic
	Music.PlayFileLoop ("music/carelessWhisper.mp3")
end introMusic

% Game music
process gameMusic
	Music.PlayFileLoop ("music/guessWhosBack.mp3")
end gameMusic

% When user wins music
process winMusic
    Music.PlayFileLoop ("music/toLiveAndDieInLA.mp3")
end winMusic

% When user loses music
process loseMusic
    Music.PlayFileLoop ("music/dearMama.mp3")
end loseMusic

% Clicks for all the buttons
process click
    Music.PlayFile ("music/click.wav")
end click

% Clicks for the radio buttons
process click2
    Music.PlayFile ("music/clickChar.wav")
end click2
