# SolverComparator

A few scripts to compare optimization solvers from various sources. Comparisons are performed in the NLPModel framework. Also, some additional problems are provided.

For now, only unconstrained optimization is considered. Supported solvers are variants from
- NLopt (7 gradient based variants)
- Ipopt (full hessian and limited memory approximation variants)
- Knitro (untested)
- Optimize (trunk and lbfgs)
- ARCTR (20 variants, 4 more using the MA97 HSL package available)

src/ExtSolvers contains wrappers to solvers from
- Ipopt
- NLopt
- LbfgsB (not an official julia Pkg)
- Knitro (not an open source solver)

src/Ampl_JuMP contains some problems used for testing, both modeled in JuMP and AMPL
- bray and braxy: brachistochrone models
- msqrtals: an instance from the CUTEst collection translated both in JuMP and AMPL
- test script to validate that both models are equivalent

src/tests contains several script helpful to compare solvers from any source. They should serve as examples.
- test_ext_solvers: tests the provided wrappers to external solvers on the rosenbrock test function
- CUTEstUnc.list: list of unconstrained models in CUTEst
- testAMPL: test many solvers on ampl models. The ampl models should be obtained elsewhere.
- testCUTE test many solvers on the CUTEstUnc.list
- testMPB test many solvers on models from OptimizationModels.
