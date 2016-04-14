# MLSSVR
Multi-output Least-Squares Support Vector Regressor

1. Usage
===========

matlab> [alpha, b] = MLSSVRTrain(training_instance_matrix, training_label_vector, gamma, lambda, p);

        -training_instance_matrix:
            An n by d matrix of d training instances with d features.
            It should be dense (type must be double).
        -training_label_vector:
            An n by 1 vector of training labels (type must be double).
        -gamma: 
            A positive real regularized parameter (type must be double). 
        -lambda: 
            Another positive real regularized parameter (type must be double). 
        -p: 
            The positive hyperparameter of radial basis function (RBF) kernel function (type must be double). 

matlab> [predicted_label, total_squared_error, squared_correlation_coefficient] = MLSSVRPredict(testing_instance_matrix, testing_label_vector, training_instance_matrix, alpha, b, lambda, p);

        -testing_instance_matrix:
            An n by d matrix of n testing instances with d features.
            It should be dense (type must be double). 
        -testing_label_vector:
            An n by 1 vector of prediction labels. If labels of test
            data are unknown, simply use any random values. (type must be double)
        -training_instance_matrix: 
            The instance matrix used for training. 
        -alpha:
            The output of MTLSSVRTrain.
        -b: 
            The output of MTLSSVRTest. 
        -lambda:
            A positive real regularized parameter.
            It should be same as counterpart in MTLSSVRTrain. 
        -p: 
            The positive hyperparameter of RBF kernel function. 
            It should be same as counterpart in MTLSSVRTrain. 

2. Examples
===========

Train and test on the provided data polymer:

matlab> load polymer.mat
matlab> [alpha, b] = MLSSVRTrain(trnX, trnY, 0.5, 4, 2);
matlab> [predict_label, total_squared_error, squared_correlation_coefficient] = MLSSVRPredict(tstX, tstY, trnX, alpha, b, 4, 2); 

In order to select proper parameters with 10-fold cross validation, you can use the following utility: 

matlab> load polymer.mat
matlab> [gamma, lambda, p, MSE] = GridMLSSVR(trnX, trnY, 10); 


3. Additional Information
=========================

This toolbox is written by XU, Shuo from Institute of Scientific and 
Technical Information of China (ISTIC). If you find this toolbox useful, 
please cite MLS-SVR as follows

[1] Shuo Xu, Xin An, Xiaodong Qiao, Lijun Zhu, and Lin Li, 2013. Multi-Output
Least-Squares Support Vector Regression Machines. Pattern Recognition Letters, 
Vol. 34, No. 9, pp. 1078-1084. DOI: 10.1016/j.patrec.2013.01.015. 

For any question, please contact XU, Shuo <xush@istic.ac.cn> OR <pzczxs@gmail.com>.
