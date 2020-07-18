# &#129680; Cosmological-Perturbations
If you've ever wondered what a PhD in theoretical physics might *actually* entail, including the day-to-day work, look no further! Here is a complete representation of my 5.5 years of research and coursework. All compactified into a single repo. It has the work I did on the daily grind (`research_bulk`), the code I wrote to make it possible (`Mathematica`), and the final polished outcomes (`research_highlights`). Thankfully, I adopted LaTeX early on and used it for everything, so most of the output consists of nicely formatted pdf's. Feel free to explore and/or make use of it!
 
[What did I research?](#research-summary)

## Contents
* Research Highlights
  - <a href="research_highlights/SVT_Decomposition_Theorem.pdf">SVT Decomposition Theorem</a>: Most recent publication that analyzes the cosmological decomposition theorem (61 pages)
  - <a href="research_highlights/Cosmological_Perturbations_II.pdf">Cosmological Perturbations II</a>: Publication regarding cosmological perturbations in a theory of gravitation called conformal gravity (39 pages)
  - <a href="research_highlights/Fluctuations_Summary_Matthew.pdf">Fluctuations Summary</a>: Inlcudes many useful methods specific to dynamics in conformal gravity
  - <a href="research_highlights/GR_waves_notes.pdf">GR Waves Notes</a>: Initial research into gravitational wave project; orbital decay of a binary star system within conformal gravity
  - <a href="research_highlights/Helicity_Decomposition_Matthew_v1.pdf">Helicity Decomposition</a>: Frames the scalar, vector, tensor (SVT) decomposition from a group-theoretic point of view; generalizes well beyond cosmology
  - <a href="research_highlights/Thesis_Phelps_2020.pdf">Thesis</a>: Final thesis
  - <a href="research_highlights/Disseratation_Defense.pdf">Dissertation Defense</a>: Presentation used in final defense
  - Some other nice examples pertaining to boundary conditions and gauge invariance in cosmology, as well as my thesis and dissertation defense
* Research Bulk
  - Organized by year, these pdf's represent day-to-day work output
  - Incorporates output of calculations performed in Mathematica
  - Presented weekly/bi-weekly to research group
* Mathematica
  - Contains day-to-day calculations performed in Mathematica; generating equations, varying geometries, decomposing tensors, and extensive simplification methods
  - Simplifying equations in general relativity requires software capable of symbolic tensor calculus
  - The third party package called [xAct](http://www.xact.es/index.html) allows one to take special derivatives (covariant derivatives), refactor dummy indices on tensors, expand metric connections, etc
  - `SVT3_RW.nb`, `SVT4_General.nb`, and `3_1_Splitting.nb` are the most heavily used modules, continually modified over multiple years
  - Unfortunately GitHub does not render Mathematica files; even worse, Mathematica is not open-source; in the future I may try to host them within jupyter notebooks on my server - we'll see!
* Coursework
  - Consists of all completed graduate course assignments spanning about 10 classes
  - Includes many solved problems for prelim exam preparation
* Extra
  - Contains reference papers
  - Undergrad research publication, presentation, and Mathematica files


## Research Summary
### Low-Detail
My research mainly focused around composing methods that simplify the equations that describe the large scale evolution of the universe. Physicists that study the unvierse as a whole are called cosmologists. Don't trust a cosmologist to do your hair - leave that to cosmetologists! Cosmologists can be contrasted with astrophysicists who study more localized events happening in the universe - black holes, galaxies, star formation, etc. 

Getting back to the research, the equations that describe the dynamics of the universe over time, i.e. going from a ball of hot dense gas all the way to forming large scale structures like clusters of galaxies, are unfortunately very unwieldly and difficult to solve (even with a computer!). As such, a large part of my research has dealt with formulating methods that decompose the cosmological equations into simpler subsets of equations according to their particular transformation properties. By applying these detailed decompositions, one application we found was that we were able to determine the growth of fluctuations in the early universe in the context of conformal gravity. (Roughly speaking, conformal gravity is a theory of gravitation that is invariant special scale transformations that stretch, bend, and compactify space).

### High-Detail
In the theory of cosmological perturbations, extensive methods of simplifying the equations of motion and eliminating non-physical gauge modes are required in order to construct the perturbative solutions. One approach, standard within modern cosmology, is to decompose the metric perturbation into a basis of scalars, vectors, and tensors defined according to their transformation behavior under three-dimensional rotations (the S.V.T. decomposition). By constructing a projector formalism to define the basis components, we show that such a decomposition is intrinsically non-local and necessarily incorporates spatially asymptotic boundary conditions. We continue application of the S.V.T. decomposition and solve the fluctuation equations exactly within standard cosmologies as applied to both Einstein gravity and conformal gravity, finding that in general the various S.V.T. gauge-invariant combinations only decouple at a higher-derivative level. To match the underlying transformation group of General Relativity and thus provide a manifestly covariant formalism, we introduce an alternate scalar, vector, tensor basis with components defined according to general four-dimensional coordinate transformations. In this basis, the fluctuation equations greatly simplify, where one can again decouple them into separate gauge-invariant sectors at the higher-derivative level. In the context of conformal gravity, we use similar constructions to solve the fluctuation equations exactly within any geometry that is conformal to flat and show that in a radiation era Robertson-Walker cosmology, fluctuations grow as t^4.

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


