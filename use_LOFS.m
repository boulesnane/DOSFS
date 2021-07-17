function pOut = use_LOFS(add)
 
if datenum(version('-date')) >= datenum('May 6 2004')
 % look at this lovely mutual incompatibility between R14+ and previous releases
 % well done MathWorks, you've made our lives needlessly difficult AGAIN!
 d = dbstack('-completenames');
 rootdir = fileparts(d(1).file);
else
 d = dbstack; 
 rootdir = fileparts(d(1).name)
end   

subdirs=LOFS_subdirs;
% if nargin 
addpath(subdirs{:});
addpath(rootdir);
