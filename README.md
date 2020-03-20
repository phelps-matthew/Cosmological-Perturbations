# &#129680; Cosmological-Perturbations
Ever wonder what a PhD in theoretical physics *actually* might look like? Look no further! Here is a complete representation of my 6 years of research and coursework. All compactified into a single repo. Thankfully, I adopted LaTeX early on and used it for everything, so most of the output consists of nicely formatted pdf's.

[What did I research?](#what-did-i-research-)

## Contents
* Research Highlights
  - <a href="research_highlights/SVT_Decomposition_Theorem.pdf">SVT decomposition Theorem</a>: Most recent publication that analyzes the cosmological decomposition theorem (61 pages)
  - <a href="research_highlights/Cosmological_Perturbations_II.pdf">Cosmological Perturbations II</a>: Publication regarding cosmological perturbations in a theory of gravitation called conformal gravity (39 pages)
  - <a href="research_highlights/Fluctuations_Summary_Matthew.pdf">Fluctuations Summary</a>: Inlcudes many useful methods specific to dynamics in conformal gravity
  - <a href="research_highlights/GR_waves_notes.pdf">GR Waves Notes</a>: Initial research into gravitational wave project; radiation decay of a binary star system within conformal gravity
  - <a href="research_highlights/Helicity_Decomposition_Matthew_v1.pdf">Helicity Decomposition</a>: Frames the scalar, vector, tensor (SVT) decomposition from a group-theoretic point of view; generalizes well beyond cosmology
  - Some other nice examples pertaining to boundary conditions and gauge invariance in cosmology
* Research Bulk
  - Organized by year, these pdf's represent day-to-day work output
  - Incorporates output of calculations performed in Mathematica
  - Presented weekly/bi-weekly to research group
* Mathematica
  - Contains day-to-day calculations performed in Mathematica; generating equations, varying geometries, decomposing perturbations, and extensive simplification methods
  - Simplifying equations in general relativity requires software capable of symbolic tensor calculus
  - The third party package called [xAct](http://www.xact.es/index.html) allows one to take covariant derivatives, refactor dummy indicies, expand into Christoffel's, etc
  - `SVT3_RW.nb`, `SVT4_General.nb`, and `3_1_Splitting.nb` are the most heavily used modules, continually modified over multiple years
  - Unfortunately GitHub does not render Mathematica files; even worse, Mathematica is not open-source; in the future I may try to host them within jupyter notebooks on my server - we'll see!
* Coursework
  - Consists of all completed graduate course assignments spanning about 10 classes
  - Includes many solved problems for prelim exam preparation
* Extra
  - Contains reference papers
  - Undergrad research publication, presentation, and Mathematica files


## What did I research?
### High-level
My research mainly focused around analyzing the equations that describe the large scale evolution of the universe. Physicists that study the unvierse as a whole are called cosmologists. Don't trust a cosmologist to do your hair - leave that to cosmetologists! Cosmologists can be contrasted with astrophysicists who study more localized events happening in the universe - black holes, galaxies, star formation, etc. 

Getting back to the research, a large part of my work dealt with what is called the *cosmological decomposition theorem*. Essentially, this is a method regularly used by the cosmology/astrophysics community to simplify and solve the equations that describe the dynamics of the universe. My research uncovered many inherent limitations to the decomposition theorem and formulated new approaches that cast the equations into a reduced form that is readily solvable. 

### Low-level
In perturbing the Einstein equations around a cosmological background (i.e., Roberston Walker, DeSitter, or Minkowski spacetime), we are left with a large set of non-linear coupled PDE's. To simplify their form, the metric and matter perturbations are then decomposed into irreducible SO(3) representations. According to the decomposition theorem, the equations of motion *themselves* are then taken to decouple into like-representations. That is, scalars are only coupled with scalers, vector with vectors, and tensors with tensors. My research team has determined that such a decomposition is strictly dependent on the choice of boundary conditions and does not hold in general. By exploring a variety of universe geometries, we provide explicit counter-examples that demonstrate well-behaved phsyical behavior but nonetheless violate the theorem. Moreover, we introduce a new 4 dimensional scalar, vector, tensor (SVT) decomposition that simplifies the equations further and does not break the covariant form of the perturbations. 

## Undergrad Research

In the gifs below, the blue arrow represents the magnetic field of a nanoparticle (magnetiziation vector, specifically). The green and red vectors are static and oscillating external magnetic fields, respectively. The equations that describe the motion of the nanoparticle's magnetic field (blue vector) are non-linear and have to be solved numerically. 

In fact, the form of these equations make many parallels to equations that describe a physical pendulum.

Normally, the natural frequency mode will decay quickly in the presence of an external magnetic field. That is, its transient response is short-lived. We see here the blue vector eventually lines up with the green vector.

<img src="/extra/undergrad_research/CSURF_Presentation/presentation_figures/gifs/hx0_Precession.gif"  width="400"><img src="/extra/undergrad_research/CSURF_Presentation/presentation_figures/gifs/hx0_FT.gif"  width="400">

However, if we add in an oscillating field (red-vector) in the x-direction, we see the transient response has some persistance.

<img src="/extra/undergrad_research/CSURF_Presentation/extra/hx100.gif"  width="400"><img src="/extra/undergrad_research/CSURF_Presentation/presentation_figures/gifs/hx100_FT.gif"  width="400">

If we increase the magnitude of the oscillating field (red vector) to a critical strength, we can infact increase the decay time by a factor of 10^4!

<img src="/extra/undergrad_research/CSURF_Presentation/extra/hx430.gif"  width="400"><img src="/extra/undergrad_research/CSURF_Presentation/presentation_figures/gifs/hx430_FT.gif"  width="400">

Owing to the nonlinear nature of the magnetization equations, we have effectively identified an unexpected mechanism by which we can tune the transient response!

Here is our publication on these results - <a href="extra/undergrad_research/CSURF_Presentation/Final_paper.pdf">Tunable transient  decay times in nonlinear systems: application to magnetic precession</a>


