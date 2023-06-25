function PosPlay = PCPlay(Board)
%start with dumb computer - randomly select open spot
[row,col] = find(Board == 0);
sel = randi([1,length(row)]);
x = row(sel);
y = col(sel);
PosPlay = [x,y];
end