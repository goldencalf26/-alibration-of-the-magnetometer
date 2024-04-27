fileID = fopen('Sphere.log','r');
data = textscan(fileID, '%s', 'Delimiter', '\n');
str = '';
for i = 1:numel(data{:})
    str = [str data{1}{i}];
end
fclose(fileID);
l = length(str) - 1;
data = [];
for i = 0:l/3
    data = [data hex2dec(str(i*3+1:i*3+2))];
end
data = uint8(data);