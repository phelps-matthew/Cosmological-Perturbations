(* ::Package:: *)

(* ::Section:: *)
(*Initialization*)


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


ToString[resources]>>"/home/map14010/res.txt"


Needs["SubKernels`RemoteKernels`"]
Parallel`Settings`$MathLinkTimeout=100
user="map14010";
password="duality2.";
ssh="ssh";(*ssh program name.If you install GOW on Windows,then this should work,otherwise put the path yourself*)math="MathKernel"<>" -wstp -linkmode Connect `4` -linkname `2` -subkernel -noinit >&  /dev/null &";
number=1;(*number of parallel kernels to launch*)machine=Keys[resources[[2]]];
remote=SubKernels`RemoteKernels`RemoteMachine[machine,ssh<>" "<>user<>"@"<>machine<>" "<>"-pw "<>password<>" \""<>math<>"\"",number];


EvaluationData[1];


ToString[remote//InputForm]>>"/home/map14010/remote.txt"


kerns=ToString[EvaluationData[LaunchKernels[remote]]]>>"launch.txt"


(*ParallelEvaluate[$MachineName]*)


CloseKernels[];


Exit[];
