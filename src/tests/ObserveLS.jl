using OptimizationProblems
using NLPModels


# Other packages available

# L-BFGS-B  --  one solver; uses only :Grad
#using Lbfgsb
#include("../ExtSolvers/L-BFGS-B.jl")


# Optimize  --  two solvers,  trunk (:HesVec) and lbfgs (only :Grad)

n=10

probs = filter(name -> name != :OptimizationProblems 
                   && name != :sbrybnd
                   && name != :penalty2
                   && name != :penalty3, names(OptimizationProblems))


mpb_probs = (MathProgNLPModel(eval(p)(n),  name=string(p) )   for p in probs)
tst_prob = MathProgNLPModel(eval(:woods)(n),  name=string(:curly) );


using LSDescentMethods
using LineSearch
#solver = Newlbfgs
#solver = steepest
#solver = NewtonLDLt
#solver = CG_FR
solver = CG_PR
#solver = CG_HZ
#solver = CG_HS
(x, f, ∇fNorm, iter, optimal, tired, status)=solver(tst_prob,linesearch=TR_Sec_ls,verboseLS=false, τ₀=0.001, τ₁=0.02, scaling=false)