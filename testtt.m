

scrsz = get(groot,'ScreenSize');
colorPSscreen = [0.9 0.2 0.5];
test= figure('Units','normalized','Position',[.25 .25 0.5 0.5],'Color',colorPSscreen,...
    'MenuBar','none','NumberTitle','off','Pointer','hand',Visible='on');

W2Hratio = scrsz(3) / scrsz(4);
H   = .15 * W2Hratio;
B2T = .9 - H;
W   = .15;
gap = .003;

for i = 1:3
    L2R = .27;
    for j = 1:3       
grid{i,j} = uicontrol('Style','pushbutton','Units','normalized','Position',[L2R B2T W H],'UserData',[i,j]);
L2R = L2R + W + gap;
    end
    B2T = B2T - H - gap * W2Hratio;
end