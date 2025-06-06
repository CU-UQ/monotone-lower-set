# Sampling for Monotone Lower Subsets of Kronecker Least Squares Problems

This repo contains code for our paper 
> O. A. Malik, Y. Xu, N. Cheng, S. Becker, A. Doostan, A. Narayan.
> *Fast Algorithms for Monotone Lower Subsets of Kronecker Least Squares Problems*.
> **arXiv preprint arXiv:2209.05662**,
> 2022.

The paper is available at [arXiv](https://arxiv.org/abs/2209.05662).

## Referencing this code

If you use this code in any of your own work, please reference our paper:
```
@misc{malik2022fast,
      title={Fast Algorithms for Monotone Lower Subsets of Kronecker Least Squares Problems}, 
      author={Osman Asif Malik and Yiming Xu and Nuojin Cheng and Stephen Becker and Alireza Doostan and Akil Narayan},
      year={2022},
      eprint={2209.05662},
      archivePrefix={arXiv},
      primaryClass={math.NA}
}
```

## Description of code

### Main files
- **duffing\_TD.m** and **duffing\_HC.m:** Codes generating Duffing oscilator data and solving the total degree/hyperbolic cross least squares problem using uniform sample, TP sampling, and leverage sampling;

- **ishigami\_TD.m** and **ishigami\_HC.m:** Codes generating Ishigami function data and solving the total degree/hyperbolic cross least squares problem using uniform sample, TP sampling, and leverage sampling.

- **battery\_test\_TD.m** and **battery\_test\_HC.m:** Codes solving the total degree/hyperbolic cross least squares battery problem using uniform sample, TP sampling, and leverage sampling.

### Sampling functions for different polynomial spaces 

- **hyperbolic\_cross\_sampling.m:** A function sampling and solving the least square problem of hyperbolic cross space with many different sampling options. The function utilizes the tensor structure and solves sampled least square problems with less time. The sampling methods provided are uniform sampling and leverage score sampling. 
- **total\_degree\_sampling.m:** Same with above, but in the total degree space.

### Help functions

- **battery\_plot.m:** Plot function for CDF of generated data;
- **duffing\_dydt**: Duffing function for ode solver;
- **my\_legendre\_1d.m:** A function generating 1d Gauss-Legendre node between -1 and 1.

### Data

- **battery\_data:** A folder containing data of battery example.

## Instruction for code running 
### Nonlinear Duffing oscillator 
1. Run matlab file **duffing\_TD.m** with following parameters:
    - `J = 7`
    - `J = 9`
2. Run matlab file **duffing\_HC.m** with following parameters: 
    - `J = 15`
    - `J = 18`
3. Run matlab file **duffing\_plot.m** and generate the figure. Since the result is random, figures generated won't be the same.
    ![Nonlinear Duffing oscillator](duffing.png)
    
### Ishigami function 
1. Run matlab file **ishigami\_TD.m** with following parameters:
    - `J = 7`
    - `J = 9`
2. Run matlab file **ishigami\_HC.m** with following parameters: 
    - `J = 15`
    - `J = 18`
3. Run matlab file **ishigami\_plot.m** and generate the figure. Since the result is random, figures generated won't be the same.
    ![Ishigami function](ishigami.png)
    
### Remaining useful life of batteries 
1. Run matlab file **battery\_test\_TD.m** with following parameters:
    - `N = 4`
    - `N = 5`
2. Run matlab file **battery\_test\_HC.m** with following parameters: 
    - `N = 4`
    - `N = 5`
3. Run matlab file **battery\_plot.m** and generate the figure. Since the result is random, figures generated won't be the same.
    ![Remaining useful life of batteries](battery_0.png)
