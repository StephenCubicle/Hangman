% Window variables
var isIntroWindowOpen : boolean
var isHangmanWindowOpen : boolean
var isInstructWindowOpen : boolean
var isGameWindowOpen : boolean
var isTopicWordWindowOpen : boolean
var isCreditsWindowOpen : boolean

% Procedure to set the window values
proc setInitialGameValues
    isIntroWindowOpen := false
    isInstructWindowOpen := false
    isGameWindowOpen := false
    isTopicWordWindowOpen := false
    isHangmanWindowOpen := false
    isCreditsWindowOpen := false
end setInitialGameValues

% Game variables
% Start of game lives
const DIFF_1_LIFE : int := 7
const DIFF_2_LIFE : int := 5
const DIFF_3_LIFE : int := 2
% End of game lives
% Space refresher for the level screen
const LVL_SPACE : string := "images/gameScreen/layoutCoverUps/spaceLvl.jpg"
const LVL_SPACE_X : int := 242
const LVL_SPACE_Y : int := 61
% End of space refresher for the level screen
% Start of lives refresher location
const DIFF_X : int := 285
const DIFF_Y : int := 90
% End of lives refresher location
var emptWord, iLetterChoice, letterChoice, storedLet : string := ""
var wordChoice : string := ""
var topicChoice, iWordChoice: string := ">>>>GAME_WON'T_WORK_UNTIL_YOU_TYPE_SOMETHING_OTHER_THAN_THIS<<<<"
var asciiCode, life : int
var picC, lifeC, c : int := 0
var wordC : int := 1
var diff : int

% Hangman window variables
const DAT_BOI_CHAR : string := "datBoi"
const SPONGE_GAR_CHAR : string := "spongeGar"
const DATBOI_IMGC : string := "db"
const SPONGE_IMGC : string := "sg"
const ENTER_SPACE : string := "images/gameScreen/layoutCoverUps/enterSpace.jpg"
const HANGMAN_AMT : int := 2
var hangChoice : int := 1
var hangChar : string := DAT_BOI_CHAR
var imgC : string := DATBOI_IMGC

% Multiple reoccuring variables in various screens
const BACK_IMG := Pic.FileNew("images/buttons/back.jpg")
const CLICK_DELAY := 500
const BG_X_Y : int := 0

% Array declaration
% Array to store the letters chosen
var letArray : flexible array 1 .. 0 of string
% Array to store the picture location within the files
var diffArray : flexible array 1 .. 0 of string
% Array to store the characters
var charChoice : array 1 .. HANGMAN_AMT of int
