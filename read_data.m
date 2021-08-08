function points = read_data(file)
    fileID = fopen(file, 'r');
    format_spec = '%f %f';
    points_trans_size = [2 Inf]; % size(points')
    points = fscanf(fileID, format_spec, points_trans_size)';
end