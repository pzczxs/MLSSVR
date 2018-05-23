# MLSSVR
Multi-output Least-Squares Support Vector Regression Machines

## 1. Introduction

### 1.1. Description
Multi-output regression aims at learning a mapping from a multivariate input feature space to a multivariate output space. Despite its potential usefulness, the standard formulation of the least-squares support vector regression machine (LS-SVR) [1][2] cannot cope with the multi-output case. The usual procedure is to train multiple independent LS-SVR, thus disregarding the underlying (potentially nonlinear) cross relatedness among different outputs. 

To address this problem, inspired by the multi-task learning methods (such as [3]), Xu et. al. [4] proprosed a novel approach, Multi-output LS-SVR (MLS-SVR), in multi-output setting. MLSSVR is a MATLAB implementation of MLS-SVR with the more efficient training algorithm in [4]. 

### 1.2. News, Comments, and Bug Reports.
We highly appreciate any suggestion, comment, and bug report.

### 1.3. License
MLSSVR is a free MATLAB toolbox; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

MLSSVR is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with MLSSVR; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.

## 2. How to Use MLS-SVR

### 2.1. Command Line & Input Parameters

```
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
```

```
matlab> [predicted_label, total_squared_error, squared_correlation_coefficient] = MLSSVRPredict(testing_instance_matrix, testing_label_vector, training_instance_matrix, alpha, b, lambda, p);
  -testing_instance_matrix: 
    An n by d matrix of n testing instances with d features. It should be dense (type must be double). 
  -testing_instance_matrix:
    An n by d matrix of n testing instances with d features.
    It should be dense (type must be double). 
  -testing_label_vector:
    An n by 1 vector of prediction labels. If labels of test
    data are unknown, simply use any random values. (type must be double)
  -training_instance_matrix: 
    The instance matrix used for training. 
  -alpha:
    The output of MLSSVRTrain.
  -b: 
    The output of MLSSVRTrain. 
  -lambda:
    A positive real regularized parameter.
    It should be same as counterpart in MLSSVRTrain. 
  -p: 
    The positive hyperparameter of RBF kernel function. 
    It should be same as counterpart in MLSSVRTrain.  
```

### 2.2. Examples

Train and test on the provided data polymer:

```
matlab> load polymer.mat
matlab> [alpha, b] = MLSSVRTrain(trnX, trnY, 0.5, 4, 2);
matlab> [predict_label, total_squared_error, squared_correlation_coefficient] = MLSSVRPredict(tstX, tstY, trnX, alpha, b, 4, 2); 
```

In order to select proper parameters with 10-fold cross validation, you can use the following utility: 

```
matlab> load polymer.mat
matlab> [gamma, lambda, p, MSE] = GridMLSSVR(trnX, trnY, 10); 
```

### 2.3. Additional Information

This toolbox is written by [XU, Shuo](http://54xushuo.net/wiki/) from [Beijing University of Technology](http://www.bjut.edu.cn). If you find this toolbox useful, please cite MLS-SVR as follows:

Shuo Xu, Xin An, Xiaodong Qiao, Lijun Zhu, and Lin Li, 2013. [Multi-Output Least-Squares Support Vector Regression Machines](http://doi.org/10.1016/j.patrec.2013.01.015). Pattern Recognition Letters, Vol. 34, No. 9, pp. 1078-1084. 

For any question, please contact XU, Shuo at <xushuo@bjut.edu.cn> OR <pzczxs@gmail.com>.

## 3. References
[1] C. Saunders, A. Gammerman, and V. Vovk, 1998. Ridge Regression Learning Algorithm in Dual Variables. *Proceedings of the 15th International Conference on Machine Learning (ICML)*, pp. 515-521. 

[2] Johan A. K. Suyken, Tony van Gestel,  Jos de Brabanter, Bart de Moor, and Joos Vandewalle, 2002. Least-Squares Support Vector Machines. World Scientific Pub. Co.

[3] Theodoros Evgeniou and Massimiliano Pontil, 2004. Regularized Multi-Task Learning. *Proceedings of the 10th ACM SIGKDD International Conference on Knowledge Discovery and Data Mining (KDD)*, pp. 109-117. 

[4] Shuo Xu, Xin An, Xiaodong Qiao, Lijun Zhu, and Lin Li, 2013. [Multi-Output Least-Squares Support Vector Regression Machines](http://doi.org/10.1016/j.patrec.2013.01.015). *Pattern Recognition Letters*, Vol. 34, No. 9, pp. 1078-1084. 
