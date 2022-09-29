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
- **duffing\_TD.m/duffing\_HC.m:** Codes generating Duffing oscilator data and solving the total degree/hyperbolic cross least squares problem using uniform sample, TP sampling, and leverage sampling;

- **ishigami\_TD.m/ishigami\_HC.m:** Codes generating Ishigami function data and solving the total degree/hyperbolic cross least squares problem using uniform sample, TP sampling, and leverage sampling.

- **battery\_test\_TD.m/battery\_test\_HC.m:** Codes solving the total degree/hyperbolic cross least squares battery problem using uniform sample, TP sampling, and leverage sampling.

### Sampling functions for different polynomial spaces 

- **hyperbolic\_cross\_sampling.m:** A function sampling and solving the least square problem of hyperbolic cross space with many different sampling options. The function utilizes the tensor structure and solves sampled least square problems with less time. The sampling methods provided are uniform sampling and leverage score sampling. 
- **total\_degree\_sampling.m:** Same with above, but in the total degree space.

### Help functions

- **duffing/ishigami/battery\_plot.m:** Plot function for CDF of generated data;
- **duffing\_dydt**: Duffing function for ode solver;
- **my\_legendre\_1d.m:** A function generating 1d Gauss-Legendre node between -1 and 1.

### Data

- **battery\_data:** A folder containing data of battery example.
