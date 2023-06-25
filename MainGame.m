function MainGame(~,~,PlayerMode,Player1name,Player2name)
close(allchild(0))

% PlayerMode
% Player1name
% Player2name
% for testing when not in a function
% clc, clear
% Player1name = 'person 1';
% Player2name = 'person 2 or computer';
% figure for the game
scrsz = get(groot,'ScreenSize');
Bcolor = [0.9 0.3 0.5];
MAIN = figure('Position',scrsz,'Color',Bcolor,'MenuBar','none','NumberTitle','off',...
    'Pointer','hand','Visible','on');
% position: left to right, bottom to top, width, height
% color: red, green, blue [0 0 0] = black, [1 1 1] = white
%variables related to title picture etc stuff
TITLE = uicontrol('Style','text','Units','normalized','Position',[.325 .91 .45 .08],'String','Tic Tac Toe!','FontWeight','bold',...
    'FontSize',50,'ForegroundColor','b','BackgroundColor',Bcolor);
WHOSTURN = uicontrol('Style','text','Units','normalized','Position',[.1 .85 .1 .05],'String','It''s Your Turn!','FontWeight','bold',...
    'FontSize',20,'ForegroundColor','b','BackgroundColor',Bcolor);
Player1Win = uicontrol('style','text','visible','on','String',[Player1name,'''s number of wins'],...
    'Backgroundcolor',Bcolor,'units','normalized','position',[.05, .6, .1, .1],'FontWeight','bold','FontSize',15,'ForegroundColor','b');
Player2Win = uicontrol('style','text','visible','on','String',[Player2name,'''s number of wins'],...
    'Backgroundcolor',Bcolor,'units','normalized','position',[.15, .6, .1, .1],'FontWeight','bold','FontSize',15,'ForegroundColor','b');

%decide who goes first
flip = round(rand);
if flip == 0
    StartPlayername = Player1name;
    NUM = 1;
    otherplayer = Player2name;
else
    StartPlayername = Player2name;
    NUM = -1;
    otherplayer = Player1name;
end

W = .15; % width of buttons
% create pictures for players and computer
%computer player pictures first:
if strcmpi(Player2name,'Computer')
    optPCpic = {'BB8','C3PO','R2D2'};
    PCpic = optPCpic{randi([1,length(optPCpic)])};
    pic2name = sprintf('%s.jpg',PCpic);
    pic2full = imread(pic2name);
    pic2 = imresize(pic2full,[W*scrsz(3),NaN]);
end
%players pictures:
optPlayerpic = {'babyyoda','chewbaca','hansolo','leia','luke','vader','windu','yoda'};
RAND = randperm(length(optPlayerpic));
Play1pic = optPlayerpic{RAND(1)};
pic1name = sprintf('%s.jpg',Play1pic);
pic1full = imread(pic1name);
pic1 = imresize(pic1full,[W*scrsz(3),NaN]);
if ~strcmpi(Player2name,'Computer')
    Play2pic = optPlayerpic{RAND(2)};
    pic2name = sprintf('%s.jpg',Play2pic);
    pic2full = imread(pic2name);
    pic2 = imresize(pic2full,[W*scrsz(3),NaN]);
end
%variables related to changing data/game play
DATA.youreup = uicontrol('Style','text','Units','normalized','String',StartPlayername,'Position',[.1 .75 .1 .1],'FontSize',20,...
    'FontWeight','bold','ForegroundColor','b','BackgroundColor',Bcolor,'Value',NUM,'UserData',otherplayer);
DATA.trackplayed = uicontrol('Style','text',Visible='off',UserData=zeros(3,3));
DATA.player1 = uicontrol('Style','text','visible','on','String','0','Value',1,'UserData',0,...
    'BackgroundColor',Bcolor,'units','normalized','position',[.05, .5, .1, .1],'FontWeight','bold','FontSize',30);
DATA.player2 = uicontrol('Style','text','Visible','on','String','0','Value',-1,'UserData',0,...
    'BackgroundColor',Bcolor,'units','normalized','position',[.15, .5, .1, .1],'FontWeight','bold','FontSize',30);
DATA.restart = uicontrol('Style','pushbutton','Units','normalized','Position',[.05 .25 .2 .1],'visible','off','String','Play Again?!','FontSize',30,...
    'FontWeight','bold','ForegroundColor','g','BackgroundColor',[0 .2 .9]);
DATA.player1button = uicontrol('style','text','visible','off','String', Player1name,'UserData',pic1);
DATA.player2button = uicontrol('style','text','visible','off','String', Player2name,'UserData',pic2);
%positions
W2Hratio = scrsz(3)/scrsz(4);
H = .15*W2Hratio;
B2T = .9 - H;
gap = .001;
for across = 1:3
    L2R = .3;
    for down = 1:3
        grid{down,across} = uicontrol('style','pushbutton','units','normalized','position',[L2R, B2T, W, H],...
            'UserData',[down,across]);
        L2R = L2R+W+gap;
    end
    B2T = B2T - (H + gap*W2Hratio);
end
% if computer goes first, randomly assign a button to computer's spot
if strcmpi(PlayerMode,'PvC') && strcmpi(StartPlayername,Player2name)
    pause(1)
firstmoverow = randi([1,3]);
firstmovecol = randi([1,3]);
grid{firstmovecol,firstmoverow}.CData = pic2;
DATA.youreup.UserData = StartPlayername;
DATA.youreup.String = otherplayer;
DATA.youreup.Value = -NUM;
StartBoard = zeros(3,3);
StartBoard(firstmoverow,firstmovecol) = -1;
DATA.trackplayed.UserData = StartBoard;
end
for across = 1:3
    for down = 1:3
        set(grid{down,across},'Callback',{@Played,grid,DATA,PlayerMode})
    end
end
    function Played(object,~,grid,DATA,PlayerMode)
        
        Pos = object.UserData; %row,column
        %Pushed = grid{Pos(1),Pos(2)};
        
        if strcmpi(DATA.youreup.String, DATA.player1button.String)
            grid{Pos(1),Pos(2)}.CData = DATA.player1button.UserData;
        elseif strcmpi(DATA.youreup.String, DATA.player2button.String)
            grid{Pos(1),Pos(2)}.CData = DATA.player2button.UserData;
            
        else
            fprintf('Error. Player not found. Fix this...?\n')
        end
        
        %grid{Pos(1),Pos(2)}.String = DATA.youreup.String;
        %set(grid{Pos(1),Pos(2)},'enable','off')
        set(grid{Pos(1),Pos(2)},'Callback',[])
        
        Board = DATA.trackplayed.UserData; %board of plays
        
        Board(Pos(2),Pos(1)) = DATA.youreup.Value;
        DATA.trackplayed.UserData = Board;
        [IFWIN, WINNER] = CheckWin (Board);
        
        
        [DATA,grid] = PostWinCheck(IFWIN,WINNER,DATA,grid);
        
        if strcmpi(IFWIN,'yes') || strcmpi(IFWIN,'tie')
            DATA.restart.Callback = {@RestartGame,grid,DATA,PlayerMode};
        end
        
        if strcmpi(PlayerMode,'PVC') && strcmpi(IFWIN,'no')
            DATA.youreup.Value;
            DATA.youreup.String;
            PosPlay = PCPlay(Board);
            Board(PosPlay(1),PosPlay(2)) = DATA.youreup.Value;
            grid{PosPlay(2),PosPlay(1)}.CData = DATA.player2button.UserData;
            set(grid{PosPlay(2),PosPlay(1)},'Callback',[])
            DATA.trackplayed.UserData = Board;
            [IFWIN, WINNER] = CheckWin (Board);
            [DATA,grid] = PostWinCheck(IFWIN,WINNER,DATA,grid);
            if strcmpi(IFWIN,'yes') || strcmpi(IFWIN,'tie')
                DATA.restart.Callback = {@RestartGame,grid,DATA,PlayerMode};
            end
        end
        
        
        
        
        
    end
    function RestartGame(object,~,grid,DATA,PlayerMode)
        
        object.Visible = 'off';
        for across2 = 1:3
            for down2 = 1:3
                set(grid{down2,across2},'enable','on','String','','CData',[])
                set(grid{down2,across2},'Callback',{@Played,grid,DATA,PlayerMode})
            end
        end
        
        if strcmpi(PlayerMode,'PvC') && strcmpi(DATA.youreup.String,'Computer')
            pause(1)
            firstmoverow1 = randi([1,3]);
            firstmovecol1 = randi([1,3]);
            grid{firstmovecol1,firstmoverow1}.CData = DATA.player2button.UserData;
            DATA.youreup.String = DATA.youreup.UserData;
            DATA.youreup.UserData = 'Computer';
            DATA.youreup.Value = -DATA.youreup.Value;
            StartBoard1 = zeros(3,3);
            StartBoard1(firstmoverow1,firstmovecol1) = -1;
            DATA.trackplayed.UserData = StartBoard1;
        end
        
    end
end