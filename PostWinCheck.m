function [DATA,grid] = PostWinCheck(IFWIN,WINNER,DATA,grid)
if strcmpi(IFWIN,'no')
    Current = DATA.youreup.String;
    Next = DATA.youreup.UserData;
    DATA.youreup.String= Next;
    DATA.youreup.UserData = Current;
    DATA.youreup.Value = -DATA.youreup.Value;
elseif strcmpi(IFWIN,'yes')
    if WINNER == DATA.youreup.Value
        WinningPlayer = DATA.youreup.String;
    else
        WinningPlayer = DATA.youreup.UserData;
        fprintf('shouldn''t happen... why did this happen????')
    end
    if WINNER == 1
        DATA.player1.UserData = DATA.player1.UserData + 1;
        DATA.player1.String = num2str(DATA.player1.UserData);
    elseif WINNER == -1
        DATA.player2.UserData = DATA.player2.UserData + 1;
        DATA.player2.String = num2str(DATA.player2.UserData);
    else
        fprintf('Error with winning count...')
    end
    DATA.trackplayed.UserData = zeros(3,3);
    DATA.restart.Visible = 'on';
    for across1 = 1:3
        for down1 = 1:3
            set(grid{down1,across1},'enable','off')
        end
    end
%     DATA.restart.Callback = {@RestartGame,grid,DATA};
elseif strcmpi(IFWIN,'tie')
    DATA.trackplayed.UserData = zeros(3,3);
    DATA.restart.Visible = 'on';
%     DATA.restart.Callback = {@RestartGame,grid,DATA};
end
end