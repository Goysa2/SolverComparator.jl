using Optimize
using SolverComparator
using OptimizationProblems
using NLPModels


# Other packages available

# L-BFGS-B  --  one solver; uses only :Grad
#using Lbfgsb
#include("../ExtSolvers/L-BFGS-B.jl")


# Optimize  --  two solvers,  trunk (:HesVec) and lbfgs (only :Grad)

n=100

probs = filter(name -> name != :OptimizationProblems 
                   && name != :sbrybnd
                   && name != :penalty2
                   && name != :penalty3, names(OptimizationProblems))


mpb_probs = (MathProgNLPModel(eval(p)(n),  name=string(p) )   for p in probs)
tst_prob = MathProgNLPModel(eval(:woods)(n),  name=string(:woods) );



n_min = 0  # not used, OptimizationProblems may be adjusted
n_max = n

using LSDescentMethods
using LineSearch
#solver = Newlbfgs
#solver = steepest
#solver = NewtonLDLt
#solver = CG_FR
solver = CG_PR
#solver = CG_HZ
#solver = CG_HS
#(x, f, ∇fNorm, iter, optimal, tired, status)=solver(tst_prob)

include("../compare_solvers.jl")

#using ARCTR
#using HSL

solvers = [CG_FR,CG_PR,CG_HS,CG_HZ,Newlbfgs]
labels = ["Fletcher-Reeves","Polak-Ribiere","Hestenes-Stiefel","Hager-Zhang","NewLbfgs"]
options = [Dict{Symbol,Any}(:τ₀=>0.3, :τ₁=> 0.6) 
           Dict{Symbol,Any}(:linesearch => TR_Sec_ls, :τ₀=>0.45, :τ₁=>0.56) 
           Dict{Symbol,Any}(:τ₀=>0.3, :τ₁=> 0.6) 
           Dict{Symbol,Any}(:τ₀=>0.3, :τ₁=> 0.6) 
           Dict{Symbol,Any}() ]

#solvers = [NewtonMA57, ARCMA57_abs, TRMA57_abs]
#labels = ["NewtonMA57","ARCMA57_abs", "TRMA57_abs"]

#options = [Dict{Symbol,Any}(:linesearch => TR_Sec_ls, :τ₀=>0.3, :τ₁=> 0.6) 
#           Dict{Symbol,Any}(:τ₀=>0.3, :τ₁=> 0.6) 
#           Dict{Symbol,Any}(:linesearch => TR_Sec_ls, :τ₀=>0.45, :τ₁=>0.56) 
#           Dict{Symbol,Any}()  ] # The basic greedy line search


s1, P1 = compare_solvers_with_options(solvers, options, labels, mpb_probs, n_min, n_max)

#s1, P1 = compare_solver_options(solver, options, mpb_probs, n_min, n_max)
