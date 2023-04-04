% กำหนด path ของ dataset
dataset_path = 'datasets\ex_1\';

% สร้าง array เพื่อเก็บขนาดฟองอีมัลชั่น
dataset_area_list = [];

% loop ในทุกภาพใน dataset_path
files = dir(fullfile(dataset_path, '*.png'));
for i = 1:length(files)

    
    img = imread(fullfile(dataset_path, files(i).name));
    %แปลงภาพชุดข้อมูลเป็น gray scale
    gray_img = rgb2gray(img);
้อ
    %แปลงชุดข้อมูลเป็น binary
    bi = imbinarize(gray_img);

    %ทำ edge detection
    edge_img = edge(bi, 'Canny');
    labeled_img = bwlabel(edge_img);
    stats = regionprops('table',labeled_img,'Area');
    area_list = stats.Area;
    dataset_area_list{i} = [area_list];

    % แสดงภาพขอบ edge detected สีแดง
    red_edge = cat(3, ones(size(edge_img)), zeros(size(edge_img)), zeros(size(edge_img)));
    red_edge(:,:,1) = edge_img.*red_edge(:,:,1);
    red_edge(:,:,2) = edge_img.*red_edge(:,:,2);
    red_edge(:,:,3) = edge_img.*red_edge(:,:,3);

    figure;
    imshow(img);
    hold on
    h = imshow(red_edge);
    set(h, 'AlphaData', edge_img);
end
