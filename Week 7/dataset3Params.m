function [C, sigma] = dataset3Params(X, y, Xval, yval)
%EX6PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = EX6PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

k = 1;
cval = sval = [0.01,0.03,0.1,0.3,1,3,10,30];
itr = 8;
ErrMax = Inf;
for i = 1:itr
  for j = 1:itr
    model = svmTrain(X,y,cval(i),@(x1, x2) gaussianKernel(x1, x2, sval(j)));
    pred = svmPredict(model, Xval);
    err = mean(double(pred ~= yval));
    fprintf(['Model = %.f; C = %0.2f; Sigma = %0.2f; Error = %.2f \n'],k,cval(i),sval(j),err);
    k = k+1;
    if(err < ErrMax)
        ErrMax = err;
        C = cval(i);
        sigma = sval(j);
    end
  end
end
fprintf("Min error = %f; Sigma = %.2f; C = %.2f;\n",ErrMax,sigma,C);

% =========================================================================

end
