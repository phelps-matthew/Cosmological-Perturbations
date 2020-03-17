# Cosmological-Perturbations
Ever wonder what a PhD in physics *actually* might look like? Look no further! Here is a complete representation my 6 years of research and coursework. all compactified into a single repo. Thankfully, I adopted LaTeX early on and used it for everything, so most of the output consists of pdf's.

## Contents

* `research_bulk`
  - Organized by year, these pdf's represent day to day work output
  - Incorporates output of calculations performed in Mathematica
  - Presented weekely/bi-weekly to research group
* `mathematica`
  - Contains day-to-day calculations performed in Mathematica; generating equations, varying geometries, decomposing perturbations, and extensive simplification methods
  - Simplifying equations in general relativity requires software capable of symbolic tensor calculus
  - Mathematica's xAct package allows one to take covariant derivatives, refactor dummy indicies, expand into Christoffel's, etc
  - `SVT3_RW.nb`, `SVT4_General.nb`, and `3_1_Splitting.nb` are the most heavily used modules, continually modified over multiple years
* `research_highlights`
  - `SVT_Decomposition_Theorem.pdf` : Most recent publication (60 pages)
  - `Cosmological_Perturbations_II.pdf` : Publication regarding cosmological perturbations in a theory of gravitation called conformal gravity
  - `Fluctuations_Summary_Matthew.pdf`: Inlcudes many useful methods specific to dynamics in conformal gravity
  - `GR_waves_notes.pdf` : Initial research into gravitational wave project; radiation decay of binary star system within conformal gravity
  - `Helicity Decomposition_Matthew_v1.pdf` : Frames the SVT decomposition from more group-theoretic point of view; generalizes well beyond cosmology


## What did I research?
### High-level
My research mainly focused around analyzing the equations that describe the large scale evolution of the universe. Physcists that study the unvierse as a whole are called cosmologists. Don't trust a cosmologist to do your hair - leave that to cosmetologists! Cosmologists can be contrasted with astrophysicists who study more localized events happening in the universe - black holes, galaxies, star formation, etc. 

Getting back to the research, a large part of my work dealt with what is called the *cosmological decomposition theorem*. Essentially, this is a method regularly used by the cosmology/astrophysics community to simplify and solve the equations that describe the dynamics of the universe. My research uncovered many inherent limitations to the decomposition theorem and formulated new approaches that cast the equations of motion into a reduced form that is readily solvable. 

### Low-level
In perturbing the Einstein equations around a cosmological background (i.e., Roberston Walker, DeSitter, or Minkowski spacetime), we are left with a large set of non-linear coupled PDE's. To simplify their form, the metric and matter perturbations are then decomposed into irreducible SO(3) representations. According to the decomposition theorem, the equations of motion *themselves* are then taken to decouple into like-representations. That is, scalars are only coupled with scalers, vector with vectors, and tensors with tensors. My research team has determined that such a decomposition is strictly dependent on the choice of boundary conditions and does not hold in general. By exploring a variety of universe geometries we provide explicit counter-examples that demonstrate well-behaved phsyical behavior but nonetheless violate the theorem. Morevoer, we introduce a new 4 dimensional SVT decomposition that simplifies the equations further and does not break the covariant form of the perturbations. 

