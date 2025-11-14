# War Prediction Neural Network

This repository contains supplemental material for my paper, War Games and Dot Products.

This is the MATLAB code for my war prediction neural network. It was created for Honors at the College of San Mateo, an honors project with a foundation course in MATH 270 (Linear Algebra).

The neural network was made from scratch by Niko Kompella in Fall 2025.

This is the layout of the repo:

```
war-predicion-nn/
│
├── nn/                      (neural network engine code)
│   ├── main.m               (main file for training neural network)
│   ├── feedforward.m
│   ├── back_prop.m
│   ├── sigmoid.m
│   ├── generate_weights.m
|   ├── analyze_svd.m        (for analyzing SVD values generated in training)
│   ├── loss.m
|   ├── focal_loss.m
|   ├── bce_loss.m           (alternative loss functions)
│   ├── train.m
|   └── main_test.m          (testing script for neural network)
│
├── xor-test/                (xor validity test)
│   ├── xor_data.m
│   ├── train_xor.m
│   ├── test_xor.m
│   └── plot_xor_boundary.m
│
├── data/
│   ├── content/             (contains alliance, war history, and country data for python script)
│   │   ├── utf8-war.csv
|   |   ├── utf8-country_data_new.csv
│   │   └── utf8-alliance.csv
│   └── evensplice.ipynb     (interactive python notebook used to format data)
│
│
├── figures/                 (figures for the paper)
│   ├── xor-db.fig           (decision boundary for XOR in MATLAB format)
│   └── confusion-matrix.png (final confusion matrix in .PNG format)
│
└── README.md
```
