% Define the filenames of the images in the dataset
filenames = {'datasets/ex_1/0.png','datasets/ex_1/1.png', 'datasets/ex_1/2.png', 'datasets/ex_1/3.png', 'datasets/ex_1/4.png'};

% Initialize variables and arrays to store the results
num_circles = zeros(1, length(filenames));
circle_sizes = cell(1, length(filenames));

% Loop through the images and perform circle detection
for i = 1:length(filenames)
    % Load the image
    im = imread(filenames{i});

    % Convert the image to grayscale
    gray = rgb2gray(im);

    % Apply edge detection to the grayscale image
    edges = edge(gray, 'prewitt');
    

    % Detect circles in the edge image using the Hough transform
    [centers, radii] = imfindcircles(edges, [6 120],"Method","PhaseCode");

    % Store the area of the detected circles in an array
    circle_areas = pi * radii.^2;

    % Store the number of circles detected and their sizes in the results arrays
    num_circles(i) = length(centers);
    circle_sizes{i} = circle_areas;
    
    % Detect freeform objects in the edge image using the regionprops function
    stats = regionprops(edges, 'BoundingBox', 'Area');
    boxes = [stats.BoundingBox];
    areas = [stats.Area];
    sum = find(areas > 5);

    % Visualize the detected regions
    figure;
    imshow(im);
    hold on;
    viscircles(centers, radii, 'Color', 'r');
    hold off;
end
