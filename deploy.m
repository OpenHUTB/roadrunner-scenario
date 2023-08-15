% 将该工程下的所有实时代码文件格式（.mlx）文件转成.html文件
% todo 部署指定文件（git中修改的文件）
cur_dir = pwd;

% 得到当前目录下的所有.mlx文件
all_dir = genpath(cur_dir);
all_dirs = split(all_dir, ';');

%% 将.mlx文件导出为网页文件
% 获取所有的目录
for i = 1 : numel(all_dirs)-1
    cur_mlx_dir = all_dirs{i};
    % 获取当前文件夹的所有.mlx文件
    cur_all_mlx = dir(fullfile(cur_mlx_dir, '*.mlx'));
    for j = 1 : numel(cur_all_mlx)  
        cur_mlx_struct = cur_all_mlx(j);
        cur_mlx_name = cur_mlx_struct.name;
        % 原始.mlx文件的路径
        cur_mlx_path = fullfile(cur_mlx_struct.folder, cur_mlx_name);
        % 生成的网页文件的路径
        cur_mlx_folder = cur_mlx_struct.folder;
        dst_html_path = fullfile(cur_mlx_struct.folder, ...
            [cur_mlx_name(1:length(cur_mlx_name)-3), 'html']);
        % 导出网页格式到和.mlx相同的文件夹
        export(cur_mlx_path, dst_html_path);

        % 将翻译结果部署到软件中
        start_pos = strfind(cur_mlx_folder, 'roadrunner-scenario');
        matlab_html_dir = fullfile(matlabroot, "help", ...
            cur_mlx_folder(start_pos:end));
        if ~exist(matlab_html_dir, "dir"); mkdir(matlab_html_dir); end
        copyfile(dst_html_path, matlab_html_dir);
    end
end



