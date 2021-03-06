
clear all;
close all;


feat_dim = 8 * 12 * 8 * 20000;
calc_num = 200;

w = randn(feat_dim, 1);
x = randn(feat_dim, 1);

tic;
for calc_i = 1:calc_num
    y_matlab = mtimes(w', x);
end
time = toc;
fprintf('vector長:%d, matlab        での内積計算時間:%.2f\n', size(w, 1), time);

tic;
for calc_i = 1:calc_num
    y_mex = inner_product_mex(w, x);
end
time = toc;
fprintf('vector長:%d, mex           での内積計算時間:%.2f\n', size(w, 1), time);

tic;
for calc_i = 1:calc_num
    y_mex_omp = inner_product_omp_mex(w, x);
end
time = toc;
fprintf('vector長:%d, mex+openmp    での内積計算時間:%.2f\n', size(w, 1), time);

tic;
w_s = single(w);
x_s = single(x);
for calc_i = 1:calc_num
    y_mex_omp_sse = inner_product_omp_sse_mex(w_s, x_s);
end
time = toc;
fprintf('vector長:%d, mex+openmp+sseでの内積計算時間:%.2f\n', size(w, 1), time);

tic;
w_s = single(w);
x_s = single(x);
for calc_i = 1:calc_num
    y_mex_omp_avx = inner_product_omp_avx_mex(w_s, x_s);
end
time = toc;
fprintf('vector長:%d, mex+openmp+avxでの内積計算時間:%.2f\n', size(w, 1), time);

% tic;
% w_s = gpuArray(single(w));
% x_s = gpuArray(single(x));
% for calc_i = 1:calc_num
%     y_matlab_gpu = w' * x;
% end
% time = toc;
% fprintf('vector長:%d, matlab(gpu)   での内積計算時間:%f\n', size(w, 1), time);
