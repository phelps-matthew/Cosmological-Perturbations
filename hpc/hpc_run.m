(* ::Package:: *)

(* ::Section:: *)
(*Initialization*)


Needs["SubKernels`RemoteKernels`"];


slurmnodes = ToString[Environment["SLURM_JOB_NODELIST"]];


slurmcpus = ToString[Environment["SLURM_JOB_CPUS_PER_NODE"]];


resourcegrab[nodes_,cpus_]:= Module[{nodelist0,nodelist,cpulist,dash,nondash,prefix},If[!StringContainsQ[nodes,"["],{nodes,cpus},
prefix=StringReplace[nodes,"["~~__~~"]"->""];
nodelist0 = StringReplace[StringCases[nodes,"["~~__~~"]"][[1]],{"["->"","]"->""}];
dash = ToExpression[StringSplit[StringCases[nodelist0,NumberString ~~"-"~~NumberString],"-"]];dash= Flatten[Table[Range[dash[[i]][[1]],dash[[i]][[2]]],{i,1,Length[dash]}]];nondash =ToExpression[StringSplit[StringReplace[StringReplace[nodelist0,NumberString~~"-"~~NumberString->""],",,"->","],","]];nodelist=StringJoin[prefix,#]&/@ToString/@Sort[Join[dash,nondash]];
cpulist = ToExpression[StringSplit[StringReplace[StringReplace[cpus,{a:NumberString~~"(x"~~b:NumberString~~")":>ToString[Table[a,{i,1,ToExpression[b]}]]}],{"{":>"","}"->""," ":>""}],","]];Table[nodelist[[i]]->cpulist[[i]],{i,1,Length[nodelist]}]
 ]];


resources = resourcegrab[slurmnodes,slurmcpus];


cputotal = Total[Values[resources]];


(* ::Section:: *)
(*Debug*)


(*s = OpenWrite["/Users/Christy/Dropbox/Vacio/Mannheim/hpc/s1write.txt"];*)


EvaluationData[1];


w = OpenWrite["/home/map14010/write.txt"];


Write[w,StringJoin["list, cputotal :",ToString[{resources,cputotal}]]];


a=EvaluationData[LaunchKernels[RemoteMachine[Keys[resources[[2]]],1]]];


Write[w,ToString[a]];


(*Write[w,StringJoin["map: ",ToString[Map[LaunchKernels[RemoteMachine[Keys[#],Values[#]]]&,resources]]]];*)


Close[w];


CloseKernels[];


(*Quit*)


Exit[];
