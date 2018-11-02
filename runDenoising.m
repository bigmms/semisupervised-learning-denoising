close all;
clear all;
clc;

theta_0 = 0.3;
theta_1 = 0.48;
theta_2 = 0.22;

noise_type = 1;
noise_density = 0.7;

file_path =  '.\test\';
img_path_list = dir(strcat(file_path,'clock.bmp'));
img_num = length(img_path_list);

if img_num > 0 
        for j = 1:img_num  
            img_name = img_path_list(j).name;
            img_ori= imread(strcat(file_path,img_name));
            figure;
            imshow(img_ori,[]);
           
            img_noise=impulsenoise(img_ori,noise_density,noise_type);
            figure;
            imshow(img_noise,[]);
            tic
            img_recov=multi_idwfiltering_3item(img_noise,noise_type,theta_0,theta_1,theta_2);
            toc
            img_recov=uint8(img_recov);
            figure;
            imshow(img_recov,[]);
            result_psnr = psnr(img_ori,img_recov);

           
        end  
end  