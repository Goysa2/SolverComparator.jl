//using AmplNLReader
//#nlp = AmplModel("../ampl/msqrtals")  # loads the msqrtals.nl model
[asl, x0, bl, bu, v, cl, cu] = ampl_init("msqrtals.nl");

//nlp = AmplModel("../ampl/curly10")  # loads the msqrtals.nl model
nvar = length(x0)
//x0 = nlp.meta.x0

nbt=100000
mprintf("evaluating %i times the Hv product\n",nbt)
gout=ampl_evalg(asl,x0);

for i=1:nbt
  Hvout = ampl_eval_hvcomp(asl,v);
  //Hg = hprod!(nlp, x0, x0, Hg)
end
mprintf("done")

// Scilab: no abnormal memory consumption.

// Julia: 
//# consume ~7.3 Gb  memory
//# gc() frees nothing
//# executing a second time eventually reaches my 16 Gb and begin swapping
