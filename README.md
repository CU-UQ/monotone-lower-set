# Monotone Lower Set Sampling

## Description of code

### Main files
- **duffing\_TD.m/duffing\_HC.m:** Codes generate Duffing oscilator data and solve the total degree/hyperbolic cross least squares problem using uniform sample, TP sampling, and leverage sampling;

- **ishigami\_TD.m/ishigami\_HC.m:** Codes generate Ishigami function data and solve the total degree/hyperbolic cross least squares problem using uniform sample, TP sampling, and leverage sampling;

### Sampling functions for <ins>hyperbolic cross</ins> polynomial spaces 

- **hyperbolic\_cross\_sampling.m:** This function samples and solve the least square problem with many different sampling options. The function utilizes the tensor structure and solves sampled least square problems with less time. The sampling methods provided are uniform sampling and leverage score sampling. 

### Help functions

- **duffing/ishigami\_plot.m:** Plot function for CDF of generated data.
