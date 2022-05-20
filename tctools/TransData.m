% load ./alldata/3sources.mat;
% lognamePre = '3sources';
% 
% X = data;
% gt = truelabel{1}';
% save("./data_tc/3sources.mat", "X", "gt" ); 

% load ./alldata/20newsgroups.mat;
% lognamePre = '20newsgroups';
% 
% X = data;
% gt = truelabel{1}';
% save("./data_tc/20newsgroups.mat", "X", "gt" ); 

% load ./alldata/100leaves.mat;
% G{1,1} = X{1,1}';
% G{1,2} = X{1,2}';
% G{1,3} = X{1,3}';
% X = G;
% gt = Y;
% save("./data_tc/100leaves.mat", "X", "gt" ); 

% load ./alldata/ALOI_100.mat;
% G{1,1} = fea{1,1}';
% G{1,2} = fea{1,2}';
% G{1,3} = fea{1,3}';
% G{1,4} = fea{1,4}';
% X = G;
% save("./data_tc/ALOI_100.mat", "X", "gt" ); 

% load ./alldata/Animal.mat;
% G{1,1} = X{1,1}';
% G{1,2} = X{1,2}';
% G{1,3} = X{1,3}';
% G{1,4} = X{1,4}';
% X = G;
% gt = Y;
% save("./data_tc/Animal.mat", "X", "gt" ); 

% 
% load ./alldata/BBC.mat;
% X = data;
% gt = label';
% save("./data_tc/BBC.mat", "X", "gt" );

% load ./alldata/BBCSport.mat;
% G{1,1} = fea{1,1}';
% G{1,2} = fea{1,2}';
% X = G;
% save("./data_tc/BBCSport.mat", "X", "gt" ); 

% load ./alldata/Caltech101-7.mat;
% G{1,1} = X{1,1}';
% G{1,2} = X{1,2}';
% G{1,3} = X{1,3}';
% G{1,4} = X{1,4}';
% G{1,5} = X{1,5}';
% X = G;
% gt = Y;
% save("./data_tc/Caltech101-7.mat", "X", "gt", "categories","cateset","feanames","lenSmp"); 

% load ./alldata/CiteSeer.mat;
% G{1,1} = fea{1,1}';
% G{1,2} = fea{1,2}';
% X = G;
% save("./data_tc/CiteSeer.mat", "X", "gt" ); 

% load ./alldata/Cornell.mat;
% X = data;
% gt = label';
% save("./data_tc/Cornell.mat", "X", "gt" ); 

% load ./alldata/handwritten_2views240_216.mat;
% G{1,1} = X{1,1}';
% G{1,2} = X{1,2}';
% X = G;
% gt = Y;
% save("./data_tc/handwritten_2views240_216.mat", "X", "gt" ); 
% 
% load ./alldata/Hdigit.mat;
% G{1,1} = X{1,1}';
% G{1,2} = X{1,2}';
% X = G;
% gt = Y;
% save("./data_tc/Hdigit.mat", "X", "gt" ); 


% load ./alldata/LandUse-21.mat;
% G{1,1} = X{1,1}';
% G{1,2} = X{1,2}';
% G{1,3} = X{1,3}';
% X = G;
% gt = Y;
% save("./data_tc/LandUse-21.mat", "X", "gt" ); 
% 
% load ./alldata/MSRC-v1.mat;
% G{1,1} = data{1,1}';
% G{1,2} = data{2,1}';
% G{1,3} = data{3,1}';
% G{1,4} = data{4,1}';
% G{1,5} = data{5,1}';
% X = G;
% gt = labels;
% save("./data_tc/MSRC-21.mat", "X", "gt" ); 


% load ./alldata/NGs.mat;
% 
% X = data;
% gt = truelabel{1,1}';
% save("./data_tc/NGs.mat", "X", "gt" ); 

% load ./alldata/NUS_WIDE.mat;
% G{1,1} = fea{1,1}';
% G{1,2} = fea{1,2}';
% G{1,3} = fea{1,3}';
% G{1,4} = fea{1,4}';
% G{1,5} = fea{1,5}';
% X = G;
% save("./data_tc/NUS_WIDE", "X", "gt" ); 


% load ./alldata/ORL.mat;
% G{1,1} = X{1,1}';
% G{1,2} = X{1,2}';
% G{1,3} = X{1,3}';
% X = G;
% gt = Y;
% save("./data_tc/ORL", "X", "gt" ); 

% load ./alldata/Reuters.mat;
% X = data;
% gt = label';
% save("./data_tc/Reuters", "X", "gt" ); 

% load ./alldata/scene-15.mat;
% G{1,1} = X{1,1}';
% G{1,2} = X{1,2}';
% G{1,3} = X{1,3}';
% X = G;
% gt = Y;
% save("./data_tc/scene-15", "X", "gt" ); 

% load ./alldata/Texas.mat;
% X = data;
% gt = label';
% save("./data_tc/Texas", "X", "gt" ); 

% load ./alldata/UCI_Digits.mat;
% G{1,1} = fea{1,1}';
% G{1,2} = fea{1,2}';
% G{1,3} = fea{1,3}';
% G{1,4} = fea{1,4}';
% G{1,5} = fea{1,5}';
% G{1,6} = fea{1,6}';
% X = G;
% save("./data_tc/UCI_Digits", "X", "gt" );

% load ./alldata/Washington.mat;
% X = data;
% gt = label';
% save("./data_tc/Washington", "X", "gt" );

% load ./alldata/WebKB.mat;
% X = data;
% gt = truelabel{1,1}';
% save("./data_tc/WebKB", "X", "gt" );

% load ./alldata/WikipediaArticles.mat;
% X = data;
% gt = truelabel{1,1}';
% save("./data_tc/WikipediaArticles", "X", "gt" );

% load ./alldata/Wisconsin.mat;
% X = data;
% gt = label';
% save("./data_tc/Wisconsin", "X", "gt" );

% load ./alldata/YaleFace.mat;
% X = data;
% gt = label';
% save("./data_tc/YaleFace", "X", "gt" );

% load ./alldata/YaleB_first10.mat;
% X{1,1} = X1;
% X{1,2} = X2;
% X{1,3} = X3;
% 
% save("./data_tc/YaleB_first10", "X", "gt" );

% load 'H:/data/Caltech101-20.mat';
% viewNum = numel(X);
% G = cell(1,viewNum);
% for v = 1:viewNum
%     G{1,v} = X{1,v}';   
% end
%  
% X = G;
% gt = Y;
% save("H:/data/Caltech101-20", "X", "gt" ,"feanames"); 

% load 'H:/data/Caltech101-7-old.mat';
% viewNum = numel(X);
% G = cell(1,viewNum);
% for v = 1:viewNum
%     G{1,v} = X{1,v}';   
% end
%  
% X = G;
% gt = Y;
% save("H:/data/Caltech101-7", "X", "gt" ,"feanames"); 

% load 'H:/data/yale_mtv.mat';
% gt = double(gt);
% save("H:/data/yale_mtv.mat", "X", "gt" ); 


% load 'H:/data/hw2-more-fea.mat';
% viewNum = numel(data);
% G = cell(1,viewNum);
% for v = 1:viewNum
%     G{1,v} = data{v, 1}';   
% end
%  
% X = G;
% gt = labels;
% save("H:/data/hw2-more-fea2.mat", "X", "gt" ); 


% load 'H:/data/Mfeat.mat'; 
% X = data;
% gt = truelabel{1};
% save("H:/data/Mfeat2.mat", "X", "gt" ); 

% load 'H:/data/Hdigit-single.mat';
% viewNum = numel(X);
% for v = 1:viewNum
%     X{v} = double(X{v});   
% end
% save("H:/data/Hdigit.mat", "X", "gt" ); 
% 
% load 'H:/data/Handwritten_6view.mat';
% viewNum = numel(data);
% for v = 1:viewNum
%     X{1,v} = data{v, 1}';  
% end
% gt = labels ;
% save("H:/data/Handwritten_6view2.mat", "X", "gt" ); 


load 'H:/data/BRCA.mat';
viewNum = numel(fea);
X = cell(1,viewNum);
for v = 1:viewNum
    X{v} = fea{v}';  
end

save("H:/data/BRCA.mat", "X", "gt" ); 
