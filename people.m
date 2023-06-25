optPlayerpic = {'babyyoda','chewbaca','hansolo','leia','luke','vader','windu','yoda'};
RAND = randperm(length(optPlayerpic));
Play1pic = optPlayerpic{RAND(1)};
pic1name = sprintf('%s.png',Play1pic);
pic1full = imread(pic1name);
pic1 = imresize(pic1full,[W*scrsz(3),NaN]);