# War Prediction Neural Network

This is the MATLAB code for my war prediction neural network. It was created for Honors at the College of San Mateo, an honors project with a foundation course in MATH 270 (Linear Algebra).

The neural network was made from scratch by Niko Kompella in Fall 2025.

This is the layout of the repo:

```
war-predicion-nn/
│
├── nn/                    (neural network engine code)
│   ├── feedforward.m
│   ├── back_prop.m
│   ├── sigmoid.m
│   ├── generate_weights.m
│   ├── loss.m
│   ├── train.m
│   └── test_nn.m          (test script for training loop)
│
├── xor-test/              (xor validity test)
│   ├── xor_data.m
│   ├── train_xor.m
│   ├── test_xor.m
│   └── plot_xor_boundary.m
│
├── data/                  (data sets for war prediction)
│   └── all training input data
│
├── results/               (results for the paper, covering XOR and various training eras)
│   └── trained model outputs
│
├── figures/               (figures for the paper)
│   └── various .png and .fig files
│
└── README.md
```
