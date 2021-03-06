# Famous brachistochrone model, adapted from AMPL implementation described in
#
# Solving trajectory optimization problems via nonlinear programming: the brachistochrone case study
#
# Dussault, JP. Optim Eng (2014) 15: 819. doi:10.1007/s11081-013-9244-4
#
# Version using fixed x and y variable y=[0:n],
# and x[0],x[n],y[0] and y[n] are fixed limit conditions. 
#
# JPD Sherbrooke, October 2016

export bray

"Brachistochrone model in size `(n-1)`"
function bray(n :: Int=32; xn :: Float64 = 5.0)


    eps = 1e-8

    yn = 1.0 # 
    x0 = 0.0
    y0 = 0.0
        
    nlp = Model()
    
    x = [xn*(j/n) for j=1:n]
    @variable(nlp, y[j=1:n-1], start = (x[j]/5))
    
    dx1 = x[1] - x0
    dxn = x[n] - x[n-1] 
    dx = [ (x[j] - x[j-1]) for j=2:n-1]

    @NLexpression(nlp, dy[j=2:n-1],  (y[j] - y[j-1]))
    @NLexpression(nlp, dy1,  (y[1] - y0))
    @NLexpression(nlp, dyn,  (yn - y[n-1]))

    @NLexpression(nlp, s[j=2:n-1],  sqrt(dx[j-1]^2 + dy[j]^2)) # 
    @NLexpression(nlp, s1,  sqrt(dx1^2 + dy1^2))
    @NLexpression(nlp, sn,  sqrt(dxn^2 + dyn^2))

    @NLexpression(nlp, f[j=2:n-1],  s[j] /(sqrt(y[j-1])+sqrt(y[j])))
    @NLexpression(nlp, f1,  s1 /(sqrt(y0) + sqrt(y[1])))
    @NLexpression(nlp, fn,  sn /(sqrt(y[n-1])+sqrt(yn)))

    
    @NLobjective(
                    nlp,
                    Min,
                    sum{f[i], i = 2:n-1} + f1 + fn
                    )

  return nlp
end











