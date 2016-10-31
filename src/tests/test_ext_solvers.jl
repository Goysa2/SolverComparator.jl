#using OptimizationProblems
using JuMP
using NLPModels
using AmplNLReader



# Optimize  --  two solvers,  trunk (:HesVec) and lbfgs (only :Grad)
# using Optimize

# official julia packages:  NLopt and Ipopt
include("../ExtSolvers/solvers.jl")


# Other packages available

# L-BFGS-B  --  one solver; uses only :Grad
# uncomment if you have access to L-BFGS-B
#using Lbfgsb
#include("../ExtSolvers/L-BFGS-B.jl")

Ext_solvers = NLoptSolvers ∪ IpoptSolvers# ∪ [LbfgsB]
include("genrose.jl")

for s in Ext_solvers
    @printf(" executing solver %s on JuMP genrose(2)\n",string(s))
    model = MathProgNLPModel(genrose(2))
    (x, f, gNorm, iterB, optimal, tired, status) = s(model)
    @printf("x0 = ");show(model.meta.x0);@printf("x* = ");show(x);@printf("   f* =  %d",f);@printf("\n")
    finalize(model)
end

cmd_dir, bidon = splitdir(@__FILE__())

for s in Ext_solvers
    model = AmplModel(string(cmd_dir,"/genrose"))
    @printf(" executing solver %s on Ampl genrose\n",string(s))
    (x, f, gNorm, iterB, optimal, tired, status) = s(model)
    @printf("x0 = ");show(model.meta.x0);@printf("x* = ");show(x);@printf("   f* =  %d",f);@printf("\n")
    finalize(model)
end
