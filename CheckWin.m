function [IFWIN,WINNER] = CheckWin (Board)
%check rows

IFWIN = 'no'; %winner = 'yes' / no winner = 'no'
WINNER =[];
COLcheck = sum(Board,1);   %mesela 3 sutün 3 satır varsa her sutunu toplayıp 3 sutün tek satırlık vektör döner 
ROWcheck = sum(Board,2)';   %aynı şekilde 3 sutün 3 satır varsa her satırı toplayıp 3 satır tek sütunluk vektör döner transpozunu alıp yatay vektör yaparız
Diagonalcheck1 = Board(1,1) + Board(2,2) + Board(3,3);
Diagonalcheck2 = Board(1,3) + Board(2,2) + Board(3,1);
ALLchecks = [ROWcheck,COLcheck,Diagonalcheck1,Diagonalcheck2];
if ~isempty(find(ALLchecks == 3))
    IFWIN = 'yes';
    WINNER = 1;
elseif ~isempty(find(ALLchecks == -3))
    IFWIN = 'yes';
    WINNER = -1;
end
if (sum(sum(Board == 0))) == 0 && ~strcmpi(IFWIN,'yes')
    IFWIN = 'tie';
end
end
