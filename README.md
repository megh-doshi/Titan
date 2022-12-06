# Titan
**Titan** is a versatile CUDA-based physics simulation library that provides a GPU-accelerated environment for physics primatives like springs and masses. Library users can create masses, springs, and more complicated objects, apply constraints, and modify simulation parameters in real time, while the simulation runs asynchronously on the GPU. Titan has been used for GPU-accelerated reinforcement learning, physics and biomedical research, and topology optimization.

## Installation

Detailed instructions can be found in the [Titan user page](https://jacobaustin123.github.io/Titan). Old documentation (not necessarily up to date) can be found on the [user wiki](https://github.com/jacobaustin123/Titan/wiki/Set-Up).

**Try a simple Titan physics simulation**

```C++
#include <Titan/sim.h>

int main() {
  titan::Simulation sim;
  sim.createLattice(titan::Vec(0, 0, 10), titan::Vec(5, 5, 5), 5, 5, 5); // create lattice with center at (0, 0, 10) and given dimensions
  sim.createPlane(titan::Vec(0, 0, 1), 0); // create constraint plane
  sim.start();
}
```

This simple program produces a large lattice bouncing on the given plane:

<img src="https://i.imgur.com/zdB0ZPg.gif" width="400" height="400">

For more examples and troubleshooting, see the [github wiki](https://github.com/jacobaustin123/Titan/wiki/Set-Up). We also have a user [Google Group](https://groups.google.com/forum/#!forum/titan-library) where you can ask questions about installation and usage, and make feature requests.

Also see [this overview video](https://www.youtube.com/watch?v=IvZNL8jd77s) for an overview of the library and its capabilities.

## About

This software was written by Jacob Austin and Rafael Corrales Fatou as part of a project led by Professor Hod Lipson at the Creative Machines Lab at Columbia University. This software is released under an Apache 2.0 license.

If using this software in published work, please cite

```
J. Austin, R. Corrales-Fatou, S. Wyetzner, and H. Lipson, “Titan: A Parallel Asynchronous Library for Multi-Agent and Soft-Body Robotics using NVIDIA CUDA,” ICRA 2020, May 2020.
```

or use the BibTex

```
@inproceedings {TitanICRA,
   title	= {Titan: A Parallel Asynchronous Library for Multi-Agent and Soft-Body Robotics using NVIDIA CUDA},
   author	= {Jacob Austin, Raphael Corrales-Fatou, Soia Wyetzner, and Hod Lipson},
   bookTitle	= {Proc. of the {IEEE} International Conference on Robotics and Automation},
   month	= {May},
   year		= {2020},
   location	= {Paris, France}
}
```

