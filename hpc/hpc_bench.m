(* ::Package:: *)

(* ::Section:: *)
(*Resources*)


slurmnodes = ToString[Environment["SLURM_JOB_NODELIST"]];


slurmcpus = ToString[Environment["SLURM_JOB_CPUS_PER_NODE"]];


resourcegrab[nodes_,cpus_]:= Module[{nodelist0,nodelist,cpulist,dash,nondash,prefix},If[!StringContainsQ[nodes,"["],{nodes->ToExpression[cpus]},
prefix=StringReplace[nodes,"["~~__~~"]"->""];
nodelist0 = StringReplace[StringCases[nodes,"["~~__~~"]"][[1]],{"["->"","]"->""}];
dash = ToExpression[StringSplit[StringCases[nodelist0,NumberString ~~"-"~~NumberString],"-"]];dash= Flatten[Table[Range[dash[[i]][[1]],dash[[i]][[2]]],{i,1,Length[dash]}]];nondash =ToExpression[StringSplit[StringReplace[StringReplace[nodelist0,NumberString~~"-"~~NumberString->""],",,"->","],","]];nodelist=StringJoin[prefix,#]&/@ToString/@Sort[Join[dash,nondash]];
cpulist = ToExpression[StringSplit[StringReplace[StringReplace[cpus,{a:NumberString~~"(x"~~b:NumberString~~")":>ToString[Table[a,{i,1,ToExpression[b]}]]}],{"{":>"","}"->""," ":>""}],","]];Table[nodelist[[i]]->cpulist[[i]],{i,1,Length[nodelist]}]
 ]];


resources = resourcegrab[slurmnodes,slurmcpus];


cputotal = Total[Values[resources]];


numcpu=Values[resources[[1]]];


Export["/home/map14010/resources.txt",StringJoin["resources: ",ToString[resources],"\n numcpus: ",ToString[numcpu],"\n"]];


s=OpenWrite["/home/map14010/break.txt"];


(* ::Section:: *)
(*Parallel Setup*)


<<xAct`xTensor`


Write[s,"package"]


LaunchKernels[4]


Write[s,"Kernel Launch"]


$DistributedContexts=None;


<<xAct`xTensor`
ParallelNeeds["xAct`xTensor`"]


DefManifold[M,4,{\[Alpha],\[Beta],\[Gamma],\[Mu],\[Nu],\[Lambda],\[Sigma],\[Kappa],\[Rho],\[Eta],\[Xi],\[Chi],\[Omega],\[Zeta]}];


ParallelEvaluate[DefManifold[M,4,{\[Alpha],\[Beta],\[Gamma],\[Mu],\[Nu],\[Lambda],\[Sigma],\[Kappa],\[Rho],\[Eta],\[Xi],\[Chi],\[Omega],\[Zeta]}],Kernels[]];


DefMetric[-1,g[-\[Alpha],-\[Beta]],CD,{";","\[Del]"},PrintAs->"g"];


ParallelEvaluate[DefMetric[-1,g[-\[Alpha],-\[Beta]],CD,{";","\[Del]"},PrintAs->"g"],Kernels[]];


$PrePrint=ScreenDollarIndices;


(*DefChart[polar,M,{0,1,2,3},{tp[],r[],\[Theta][],\[Phi]p[]}];*)


(*ParallelEvaluate[DefChart[polar,M,{0,1,2,3},{tp[],r[],\[Theta][],\[Phi]p[]}],Kernels[]];*)


(*MetricInBasis[g, -polar, {-1,1,r[]^2,r[]^2Sin[\[Theta][]]^2}];*)


(*ParallelEvaluate[MetricInBasis[g, -polar, {-1,1,r[]^2,r[]^2Sin[\[Theta][]]^2}],Kernels[]];*)


(*MetricInBasis[g, polar, {-1,1,r[]^(-2),r[]^(-2)Sin[\[Theta][]]^(-2)}];*)


(*ParallelEvaluate[MetricInBasis[g, polar, {-1,1,r[]^(-2),r[]^(-2)Sin[\[Theta][]]^(-2)}],Kernels[]];*)


(*MetricCompute[g,polar,All,CVSimplify\[Rule]Simplify];*)


(*ParallelEvaluate[MetricCompute[g,polar,All,CVSimplify\[Rule]Simplify],Kernels[]];*)


DefTensor[K[-\[Alpha],-\[Beta]],M,Symmetric[{-\[Alpha],-\[Beta]}]];


ParallelEvaluate[DefTensor[K[-\[Alpha],-\[Beta]],M,Symmetric[{-\[Alpha],-\[Beta]}]],Kernels[]];


DefTensor[A[-\[Alpha]],M];


ParallelEvaluate[DefTensor[A[-\[Alpha]],M],Kernels[]];


DefTensor[AA[],M,PrintAs->"A"];


ParallelEvaluate[DefTensor[AA[],M,PrintAs->"A"],Kernels[]];


SetOptions[ToCanonical,UseMetricOnVBundle->None];


ParallelEvaluate[SetOptions[ToCanonical,UseMetricOnVBundle->None],Kernels[]];


$PrePrint=ScreenDollarIndices;


$CovDFormat="Prefix";


Write[s,"Initialization Completed"]


(* ::Section::Closed:: *)
(*Large Definitions*)


boxsub[-\[Mu]_,-\[Nu]_]:= (* \[Del]^\[Gamma]\!\(
\*SubscriptBox[\(\[Del]\), \(\[Gamma]\)]
\*SubscriptBox[\(K\), \(\[Mu]\[Nu]\)]\) *)
Module[{\[Alpha],\[Beta],\[Gamma],\[Eta],\[Kappa],\[Lambda]},
g[\[Alpha],\[Beta]]*PD[-\[Beta]][PD[-\[Alpha]][K[-\[Mu],-\[Nu]]]]+g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*PD[-\[Beta]][K[-\[Nu],-\[Eta]]]*PD[-\[Gamma]][g[-\[Mu],-\[Alpha]]]+g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*PD[-\[Beta]][K[-\[Mu],-\[Eta]]]*PD[-\[Gamma]][g[-\[Nu],-\[Alpha]]]+(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Nu],-\[Alpha]]*PD[-\[Beta]][g[-\[Mu],-\[Gamma]]]*PD[-\[Eta]][g[-\[Kappa],-\[Lambda]]])/4+(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Mu],-\[Alpha]]*PD[-\[Beta]][g[-\[Nu],-\[Gamma]]]*PD[-\[Eta]][g[-\[Kappa],-\[Lambda]]])/4-(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Nu],-\[Alpha]]*PD[-\[Gamma]][g[-\[Mu],-\[Beta]]]*PD[-\[Eta]][g[-\[Kappa],-\[Lambda]]])/4-(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Mu],-\[Alpha]]*PD[-\[Gamma]][g[-\[Nu],-\[Beta]]]*PD[-\[Eta]][g[-\[Kappa],-\[Lambda]]])/4+(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Alpha],-\[Gamma]]*PD[-\[Beta]][g[-\[Mu],-\[Kappa]]]*PD[-\[Eta]][g[-\[Nu],-\[Lambda]]])/2-g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*PD[-\[Gamma]][g[-\[Nu],-\[Alpha]]]*PD[-\[Eta]][K[-\[Mu],-\[Beta]]]-g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*PD[-\[Beta]][g[-\[Alpha],-\[Gamma]]]*PD[-\[Eta]][K[-\[Mu],-\[Nu]]]+(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*PD[-\[Gamma]][g[-\[Alpha],-\[Beta]]]*PD[-\[Eta]][K[-\[Mu],-\[Nu]]])/2-g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*PD[-\[Gamma]][g[-\[Mu],-\[Alpha]]]*PD[-\[Eta]][K[-\[Nu],-\[Beta]]]+(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*K[-\[Nu],-\[Alpha]]*PD[-\[Eta]][PD[-\[Beta]][g[-\[Mu],-\[Gamma]]]])/2+(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*K[-\[Mu],-\[Alpha]]*PD[-\[Eta]][PD[-\[Beta]][g[-\[Nu],-\[Gamma]]]])/2-(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*K[-\[Nu],-\[Alpha]]*PD[-\[Eta]][PD[-\[Gamma]][g[-\[Mu],-\[Beta]]]])/2-(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*K[-\[Mu],-\[Alpha]]*PD[-\[Eta]][PD[-\[Gamma]][g[-\[Nu],-\[Beta]]]])/2-(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*K[-\[Nu],-\[Alpha]]*PD[-\[Eta]][PD[-\[Mu]][g[-\[Beta],-\[Gamma]]]])/2-(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*K[-\[Mu],-\[Alpha]]*PD[-\[Eta]][PD[-\[Nu]][g[-\[Beta],-\[Gamma]]]])/2-(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Alpha],-\[Gamma]]*PD[-\[Eta]][g[-\[Nu],-\[Lambda]]]*PD[-\[Kappa]][g[-\[Mu],-\[Beta]]])/2-(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Nu],-\[Alpha]]*PD[-\[Eta]][g[-\[Beta],-\[Lambda]]]*PD[-\[Kappa]][g[-\[Mu],-\[Gamma]]])/2-(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Mu],-\[Alpha]]*PD[-\[Eta]][g[-\[Beta],-\[Lambda]]]*PD[-\[Kappa]][g[-\[Nu],-\[Gamma]]])/2+(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Nu],-\[Alpha]]*PD[-\[Kappa]][g[-\[Mu],-\[Gamma]]]*PD[-\[Lambda]][g[-\[Beta],-\[Eta]]])/2+(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Mu],-\[Alpha]]*PD[-\[Kappa]][g[-\[Nu],-\[Gamma]]]*PD[-\[Lambda]][g[-\[Beta],-\[Eta]]])/2-(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Nu],-\[Alpha]]*PD[-\[Beta]][g[-\[Mu],-\[Gamma]]]*PD[-\[Lambda]][g[-\[Eta],-\[Kappa]]])/2-(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Mu],-\[Alpha]]*PD[-\[Beta]][g[-\[Nu],-\[Gamma]]]*PD[-\[Lambda]][g[-\[Eta],-\[Kappa]]])/2+(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Nu],-\[Alpha]]*PD[-\[Gamma]][g[-\[Mu],-\[Beta]]]*PD[-\[Lambda]][g[-\[Eta],-\[Kappa]]])/2+(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Mu],-\[Alpha]]*PD[-\[Gamma]][g[-\[Nu],-\[Beta]]]*PD[-\[Lambda]][g[-\[Eta],-\[Kappa]]])/2-(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Alpha],-\[Gamma]]*PD[-\[Beta]][g[-\[Mu],-\[Kappa]]]*PD[-\[Lambda]][g[-\[Nu],-\[Eta]]])/2+(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Alpha],-\[Gamma]]*PD[-\[Kappa]][g[-\[Mu],-\[Beta]]]*PD[-\[Lambda]][g[-\[Nu],-\[Eta]]])/2-g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*PD[-\[Eta]][K[-\[Nu],-\[Beta]]]*PD[-\[Mu]][g[-\[Alpha],-\[Gamma]]]-(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Nu],-\[Alpha]]*PD[-\[Eta]][g[-\[Kappa],-\[Lambda]]]*PD[-\[Mu]][g[-\[Beta],-\[Gamma]]])/4+(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Nu],-\[Alpha]]*PD[-\[Lambda]][g[-\[Eta],-\[Kappa]]]*PD[-\[Mu]][g[-\[Beta],-\[Gamma]]])/2-(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Nu],-\[Alpha]]*PD[-\[Beta]][g[-\[Eta],-\[Lambda]]]*PD[-\[Mu]][g[-\[Gamma],-\[Kappa]]])/4+g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Nu],-\[Alpha]]*PD[-\[Lambda]][g[-\[Beta],-\[Eta]]]*PD[-\[Mu]][g[-\[Gamma],-\[Kappa]]]-(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Alpha],-\[Gamma]]*PD[-\[Beta]][g[-\[Nu],-\[Kappa]]]*PD[-\[Mu]][g[-\[Eta],-\[Lambda]]])/2+(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Alpha],-\[Gamma]]*PD[-\[Kappa]][g[-\[Nu],-\[Beta]]]*PD[-\[Mu]][g[-\[Eta],-\[Lambda]]])/2-g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*PD[-\[Eta]][K[-\[Mu],-\[Beta]]]*PD[-\[Nu]][g[-\[Alpha],-\[Gamma]]]-(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Mu],-\[Alpha]]*PD[-\[Eta]][g[-\[Kappa],-\[Lambda]]]*PD[-\[Nu]][g[-\[Beta],-\[Gamma]]])/4+(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Mu],-\[Alpha]]*PD[-\[Lambda]][g[-\[Eta],-\[Kappa]]]*PD[-\[Nu]][g[-\[Beta],-\[Gamma]]])/2-(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Mu],-\[Alpha]]*PD[-\[Beta]][g[-\[Eta],-\[Lambda]]]*PD[-\[Nu]][g[-\[Gamma],-\[Kappa]]])/4+g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Mu],-\[Alpha]]*PD[-\[Lambda]][g[-\[Beta],-\[Eta]]]*PD[-\[Nu]][g[-\[Gamma],-\[Kappa]]]-(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Alpha],-\[Gamma]]*PD[-\[Beta]][g[-\[Mu],-\[Kappa]]]*PD[-\[Nu]][g[-\[Eta],-\[Lambda]]])/2+(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Alpha],-\[Gamma]]*PD[-\[Kappa]][g[-\[Mu],-\[Beta]]]*PD[-\[Nu]][g[-\[Eta],-\[Lambda]]])/2+(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Alpha],-\[Gamma]]*PD[-\[Mu]][g[-\[Beta],-\[Kappa]]]*PD[-\[Nu]][g[-\[Eta],-\[Lambda]]])/2];


boxsub2=
g[\[Sigma],\[Rho]]*PDpolar[-\[Rho]][PDpolar[-\[Sigma]][K[-\[Mu],-\[Nu]]]]+g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*PDpolar[-\[Rho]][K[-\[Nu],-\[Chi]]]*PDpolar[-\[Xi]][g[-\[Mu],-\[Sigma]]]+g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*PDpolar[-\[Rho]][K[-\[Mu],-\[Chi]]]*PDpolar[-\[Xi]][g[-\[Nu],-\[Sigma]]]+(g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*g[\[Omega],\[Zeta]]*K[-\[Nu],-\[Sigma]]*PDpolar[-\[Rho]][g[-\[Mu],-\[Xi]]]*PDpolar[-\[Chi]][g[-\[Omega],-\[Zeta]]])/4+(g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*g[\[Omega],\[Zeta]]*K[-\[Mu],-\[Sigma]]*PDpolar[-\[Rho]][g[-\[Nu],-\[Xi]]]*PDpolar[-\[Chi]][g[-\[Omega],-\[Zeta]]])/4-(g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*g[\[Omega],\[Zeta]]*K[-\[Nu],-\[Sigma]]*PDpolar[-\[Xi]][g[-\[Mu],-\[Rho]]]*PDpolar[-\[Chi]][g[-\[Omega],-\[Zeta]]])/4-(g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*g[\[Omega],\[Zeta]]*K[-\[Mu],-\[Sigma]]*PDpolar[-\[Xi]][g[-\[Nu],-\[Rho]]]*PDpolar[-\[Chi]][g[-\[Omega],-\[Zeta]]])/4+(g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*g[\[Omega],\[Zeta]]*K[-\[Sigma],-\[Xi]]*PDpolar[-\[Rho]][g[-\[Mu],-\[Omega]]]*PDpolar[-\[Chi]][g[-\[Nu],-\[Zeta]]])/2-g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*PDpolar[-\[Xi]][g[-\[Nu],-\[Sigma]]]*PDpolar[-\[Chi]][K[-\[Mu],-\[Rho]]]-g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*PDpolar[-\[Rho]][g[-\[Sigma],-\[Xi]]]*PDpolar[-\[Chi]][K[-\[Mu],-\[Nu]]]+(g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*PDpolar[-\[Xi]][g[-\[Sigma],-\[Rho]]]*PDpolar[-\[Chi]][K[-\[Mu],-\[Nu]]])/2-g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*PDpolar[-\[Xi]][g[-\[Mu],-\[Sigma]]]*PDpolar[-\[Chi]][K[-\[Nu],-\[Rho]]]+(g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*K[-\[Nu],-\[Sigma]]*PDpolar[-\[Chi]][PDpolar[-\[Rho]][g[-\[Mu],-\[Xi]]]])/2+(g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*K[-\[Mu],-\[Sigma]]*PDpolar[-\[Chi]][PDpolar[-\[Rho]][g[-\[Nu],-\[Xi]]]])/2-(g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*K[-\[Nu],-\[Sigma]]*PDpolar[-\[Chi]][PDpolar[-\[Xi]][g[-\[Mu],-\[Rho]]]])/2-(g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*K[-\[Mu],-\[Sigma]]*PDpolar[-\[Chi]][PDpolar[-\[Xi]][g[-\[Nu],-\[Rho]]]])/2-(g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*K[-\[Nu],-\[Sigma]]*PDpolar[-\[Chi]][PDpolar[-\[Mu]][g[-\[Rho],-\[Xi]]]])/2-(g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*K[-\[Mu],-\[Sigma]]*PDpolar[-\[Chi]][PDpolar[-\[Nu]][g[-\[Rho],-\[Xi]]]])/2-(g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*g[\[Omega],\[Zeta]]*K[-\[Sigma],-\[Xi]]*PDpolar[-\[Chi]][g[-\[Nu],-\[Zeta]]]*PDpolar[-\[Omega]][g[-\[Mu],-\[Rho]]])/2-(g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*g[\[Omega],\[Zeta]]*K[-\[Nu],-\[Sigma]]*PDpolar[-\[Chi]][g[-\[Rho],-\[Zeta]]]*PDpolar[-\[Omega]][g[-\[Mu],-\[Xi]]])/2-(g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*g[\[Omega],\[Zeta]]*K[-\[Mu],-\[Sigma]]*PDpolar[-\[Chi]][g[-\[Rho],-\[Zeta]]]*PDpolar[-\[Omega]][g[-\[Nu],-\[Xi]]])/2+(g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*g[\[Omega],\[Zeta]]*K[-\[Nu],-\[Sigma]]*PDpolar[-\[Omega]][g[-\[Mu],-\[Xi]]]*PDpolar[-\[Zeta]][g[-\[Rho],-\[Chi]]])/2+(g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*g[\[Omega],\[Zeta]]*K[-\[Mu],-\[Sigma]]*PDpolar[-\[Omega]][g[-\[Nu],-\[Xi]]]*PDpolar[-\[Zeta]][g[-\[Rho],-\[Chi]]])/2-(g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*g[\[Omega],\[Zeta]]*K[-\[Nu],-\[Sigma]]*PDpolar[-\[Rho]][g[-\[Mu],-\[Xi]]]*PDpolar[-\[Zeta]][g[-\[Chi],-\[Omega]]])/2-(g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*g[\[Omega],\[Zeta]]*K[-\[Mu],-\[Sigma]]*PDpolar[-\[Rho]][g[-\[Nu],-\[Xi]]]*PDpolar[-\[Zeta]][g[-\[Chi],-\[Omega]]])/2+(g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*g[\[Omega],\[Zeta]]*K[-\[Nu],-\[Sigma]]*PDpolar[-\[Xi]][g[-\[Mu],-\[Rho]]]*PDpolar[-\[Zeta]][g[-\[Chi],-\[Omega]]])/2+(g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*g[\[Omega],\[Zeta]]*K[-\[Mu],-\[Sigma]]*PDpolar[-\[Xi]][g[-\[Nu],-\[Rho]]]*PDpolar[-\[Zeta]][g[-\[Chi],-\[Omega]]])/2-(g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*g[\[Omega],\[Zeta]]*K[-\[Sigma],-\[Xi]]*PDpolar[-\[Rho]][g[-\[Mu],-\[Omega]]]*PDpolar[-\[Zeta]][g[-\[Nu],-\[Chi]]])/2+(g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*g[\[Omega],\[Zeta]]*K[-\[Sigma],-\[Xi]]*PDpolar[-\[Omega]][g[-\[Mu],-\[Rho]]]*PDpolar[-\[Zeta]][g[-\[Nu],-\[Chi]]])/2-g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*PDpolar[-\[Chi]][K[-\[Nu],-\[Rho]]]*PDpolar[-\[Mu]][g[-\[Sigma],-\[Xi]]]-(g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*g[\[Omega],\[Zeta]]*K[-\[Nu],-\[Sigma]]*PDpolar[-\[Chi]][g[-\[Omega],-\[Zeta]]]*PDpolar[-\[Mu]][g[-\[Rho],-\[Xi]]])/4+(g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*g[\[Omega],\[Zeta]]*K[-\[Nu],-\[Sigma]]*PDpolar[-\[Zeta]][g[-\[Chi],-\[Omega]]]*PDpolar[-\[Mu]][g[-\[Rho],-\[Xi]]])/2-(g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*g[\[Omega],\[Zeta]]*K[-\[Nu],-\[Sigma]]*PDpolar[-\[Rho]][g[-\[Chi],-\[Zeta]]]*PDpolar[-\[Mu]][g[-\[Xi],-\[Omega]]])/4+g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*g[\[Omega],\[Zeta]]*K[-\[Nu],-\[Sigma]]*PDpolar[-\[Zeta]][g[-\[Rho],-\[Chi]]]*PDpolar[-\[Mu]][g[-\[Xi],-\[Omega]]]-(g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*g[\[Omega],\[Zeta]]*K[-\[Sigma],-\[Xi]]*PDpolar[-\[Rho]][g[-\[Nu],-\[Omega]]]*PDpolar[-\[Mu]][g[-\[Chi],-\[Zeta]]])/2+(g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*g[\[Omega],\[Zeta]]*K[-\[Sigma],-\[Xi]]*PDpolar[-\[Omega]][g[-\[Nu],-\[Rho]]]*PDpolar[-\[Mu]][g[-\[Chi],-\[Zeta]]])/2-g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*PDpolar[-\[Chi]][K[-\[Mu],-\[Rho]]]*PDpolar[-\[Nu]][g[-\[Sigma],-\[Xi]]]-(g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*g[\[Omega],\[Zeta]]*K[-\[Mu],-\[Sigma]]*PDpolar[-\[Chi]][g[-\[Omega],-\[Zeta]]]*PDpolar[-\[Nu]][g[-\[Rho],-\[Xi]]])/4+(g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*g[\[Omega],\[Zeta]]*K[-\[Mu],-\[Sigma]]*PDpolar[-\[Zeta]][g[-\[Chi],-\[Omega]]]*PDpolar[-\[Nu]][g[-\[Rho],-\[Xi]]])/2-(g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*g[\[Omega],\[Zeta]]*K[-\[Mu],-\[Sigma]]*PDpolar[-\[Rho]][g[-\[Chi],-\[Zeta]]]*PDpolar[-\[Nu]][g[-\[Xi],-\[Omega]]])/4+g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*g[\[Omega],\[Zeta]]*K[-\[Mu],-\[Sigma]]*PDpolar[-\[Zeta]][g[-\[Rho],-\[Chi]]]*PDpolar[-\[Nu]][g[-\[Xi],-\[Omega]]]-(g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*g[\[Omega],\[Zeta]]*K[-\[Sigma],-\[Xi]]*PDpolar[-\[Rho]][g[-\[Mu],-\[Omega]]]*PDpolar[-\[Nu]][g[-\[Chi],-\[Zeta]]])/2+(g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*g[\[Omega],\[Zeta]]*K[-\[Sigma],-\[Xi]]*PDpolar[-\[Omega]][g[-\[Mu],-\[Rho]]]*PDpolar[-\[Nu]][g[-\[Chi],-\[Zeta]]])/2+(g[\[Sigma],\[Rho]]*g[\[Xi],\[Chi]]*g[\[Omega],\[Zeta]]*K[-\[Sigma],-\[Xi]]*PDpolar[-\[Mu]][g[-\[Rho],-\[Omega]]]*PDpolar[-\[Nu]][g[-\[Chi],-\[Zeta]]])/2;


boxsub1=
g[\[Alpha],\[Beta]]*PDpolar[-\[Beta]][PDpolar[-\[Alpha]][K[-\[Mu],-\[Nu]]]]+g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*PDpolar[-\[Beta]][K[-\[Nu],-\[Eta]]]*PDpolar[-\[Gamma]][g[-\[Mu],-\[Alpha]]]+g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*PDpolar[-\[Beta]][K[-\[Mu],-\[Eta]]]*PDpolar[-\[Gamma]][g[-\[Nu],-\[Alpha]]]+(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Nu],-\[Alpha]]*PDpolar[-\[Beta]][g[-\[Mu],-\[Gamma]]]*PDpolar[-\[Eta]][g[-\[Kappa],-\[Lambda]]])/4+(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Mu],-\[Alpha]]*PDpolar[-\[Beta]][g[-\[Nu],-\[Gamma]]]*PDpolar[-\[Eta]][g[-\[Kappa],-\[Lambda]]])/4-(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Nu],-\[Alpha]]*PDpolar[-\[Gamma]][g[-\[Mu],-\[Beta]]]*PDpolar[-\[Eta]][g[-\[Kappa],-\[Lambda]]])/4-(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Mu],-\[Alpha]]*PDpolar[-\[Gamma]][g[-\[Nu],-\[Beta]]]*PDpolar[-\[Eta]][g[-\[Kappa],-\[Lambda]]])/4+(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Alpha],-\[Gamma]]*PDpolar[-\[Beta]][g[-\[Mu],-\[Kappa]]]*PDpolar[-\[Eta]][g[-\[Nu],-\[Lambda]]])/2-g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*PDpolar[-\[Gamma]][g[-\[Nu],-\[Alpha]]]*PDpolar[-\[Eta]][K[-\[Mu],-\[Beta]]]-g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*PDpolar[-\[Beta]][g[-\[Alpha],-\[Gamma]]]*PDpolar[-\[Eta]][K[-\[Mu],-\[Nu]]]+(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*PDpolar[-\[Gamma]][g[-\[Alpha],-\[Beta]]]*PDpolar[-\[Eta]][K[-\[Mu],-\[Nu]]])/2-g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*PDpolar[-\[Gamma]][g[-\[Mu],-\[Alpha]]]*PDpolar[-\[Eta]][K[-\[Nu],-\[Beta]]]+(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*K[-\[Nu],-\[Alpha]]*PDpolar[-\[Eta]][PDpolar[-\[Beta]][g[-\[Mu],-\[Gamma]]]])/2+(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*K[-\[Mu],-\[Alpha]]*PDpolar[-\[Eta]][PDpolar[-\[Beta]][g[-\[Nu],-\[Gamma]]]])/2-(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*K[-\[Nu],-\[Alpha]]*PDpolar[-\[Eta]][PDpolar[-\[Gamma]][g[-\[Mu],-\[Beta]]]])/2-(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*K[-\[Mu],-\[Alpha]]*PDpolar[-\[Eta]][PDpolar[-\[Gamma]][g[-\[Nu],-\[Beta]]]])/2-(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*K[-\[Nu],-\[Alpha]]*PDpolar[-\[Eta]][PDpolar[-\[Mu]][g[-\[Beta],-\[Gamma]]]])/2-(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*K[-\[Mu],-\[Alpha]]*PDpolar[-\[Eta]][PDpolar[-\[Nu]][g[-\[Beta],-\[Gamma]]]])/2-(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Alpha],-\[Gamma]]*PDpolar[-\[Eta]][g[-\[Nu],-\[Lambda]]]*PDpolar[-\[Kappa]][g[-\[Mu],-\[Beta]]])/2-(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Nu],-\[Alpha]]*PDpolar[-\[Eta]][g[-\[Beta],-\[Lambda]]]*PDpolar[-\[Kappa]][g[-\[Mu],-\[Gamma]]])/2-(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Mu],-\[Alpha]]*PDpolar[-\[Eta]][g[-\[Beta],-\[Lambda]]]*PDpolar[-\[Kappa]][g[-\[Nu],-\[Gamma]]])/2+(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Nu],-\[Alpha]]*PDpolar[-\[Kappa]][g[-\[Mu],-\[Gamma]]]*PDpolar[-\[Lambda]][g[-\[Beta],-\[Eta]]])/2+(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Mu],-\[Alpha]]*PDpolar[-\[Kappa]][g[-\[Nu],-\[Gamma]]]*PDpolar[-\[Lambda]][g[-\[Beta],-\[Eta]]])/2-(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Nu],-\[Alpha]]*PDpolar[-\[Beta]][g[-\[Mu],-\[Gamma]]]*PDpolar[-\[Lambda]][g[-\[Eta],-\[Kappa]]])/2-(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Mu],-\[Alpha]]*PDpolar[-\[Beta]][g[-\[Nu],-\[Gamma]]]*PDpolar[-\[Lambda]][g[-\[Eta],-\[Kappa]]])/2+(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Nu],-\[Alpha]]*PDpolar[-\[Gamma]][g[-\[Mu],-\[Beta]]]*PDpolar[-\[Lambda]][g[-\[Eta],-\[Kappa]]])/2+(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Mu],-\[Alpha]]*PDpolar[-\[Gamma]][g[-\[Nu],-\[Beta]]]*PDpolar[-\[Lambda]][g[-\[Eta],-\[Kappa]]])/2-(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Alpha],-\[Gamma]]*PDpolar[-\[Beta]][g[-\[Mu],-\[Kappa]]]*PDpolar[-\[Lambda]][g[-\[Nu],-\[Eta]]])/2+(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Alpha],-\[Gamma]]*PDpolar[-\[Kappa]][g[-\[Mu],-\[Beta]]]*PDpolar[-\[Lambda]][g[-\[Nu],-\[Eta]]])/2-g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*PDpolar[-\[Eta]][K[-\[Nu],-\[Beta]]]*PDpolar[-\[Mu]][g[-\[Alpha],-\[Gamma]]]-(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Nu],-\[Alpha]]*PDpolar[-\[Eta]][g[-\[Kappa],-\[Lambda]]]*PDpolar[-\[Mu]][g[-\[Beta],-\[Gamma]]])/4+(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Nu],-\[Alpha]]*PDpolar[-\[Lambda]][g[-\[Eta],-\[Kappa]]]*PDpolar[-\[Mu]][g[-\[Beta],-\[Gamma]]])/2-(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Nu],-\[Alpha]]*PDpolar[-\[Beta]][g[-\[Eta],-\[Lambda]]]*PDpolar[-\[Mu]][g[-\[Gamma],-\[Kappa]]])/4+g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Nu],-\[Alpha]]*PDpolar[-\[Lambda]][g[-\[Beta],-\[Eta]]]*PDpolar[-\[Mu]][g[-\[Gamma],-\[Kappa]]]-(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Alpha],-\[Gamma]]*PDpolar[-\[Beta]][g[-\[Nu],-\[Kappa]]]*PDpolar[-\[Mu]][g[-\[Eta],-\[Lambda]]])/2+(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Alpha],-\[Gamma]]*PDpolar[-\[Kappa]][g[-\[Nu],-\[Beta]]]*PDpolar[-\[Mu]][g[-\[Eta],-\[Lambda]]])/2-g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*PDpolar[-\[Eta]][K[-\[Mu],-\[Beta]]]*PDpolar[-\[Nu]][g[-\[Alpha],-\[Gamma]]]-(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Mu],-\[Alpha]]*PDpolar[-\[Eta]][g[-\[Kappa],-\[Lambda]]]*PDpolar[-\[Nu]][g[-\[Beta],-\[Gamma]]])/4+(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Mu],-\[Alpha]]*PDpolar[-\[Lambda]][g[-\[Eta],-\[Kappa]]]*PDpolar[-\[Nu]][g[-\[Beta],-\[Gamma]]])/2-(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Mu],-\[Alpha]]*PDpolar[-\[Beta]][g[-\[Eta],-\[Lambda]]]*PDpolar[-\[Nu]][g[-\[Gamma],-\[Kappa]]])/4+g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Mu],-\[Alpha]]*PDpolar[-\[Lambda]][g[-\[Beta],-\[Eta]]]*PDpolar[-\[Nu]][g[-\[Gamma],-\[Kappa]]]-(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Alpha],-\[Gamma]]*PDpolar[-\[Beta]][g[-\[Mu],-\[Kappa]]]*PDpolar[-\[Nu]][g[-\[Eta],-\[Lambda]]])/2+(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Alpha],-\[Gamma]]*PDpolar[-\[Kappa]][g[-\[Mu],-\[Beta]]]*PDpolar[-\[Nu]][g[-\[Eta],-\[Lambda]]])/2+(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Alpha],-\[Gamma]]*PDpolar[-\[Mu]][g[-\[Beta],-\[Kappa]]]*PDpolar[-\[Nu]][g[-\[Eta],-\[Lambda]]])/2;


pdAA[-\[Alpha]_]:=Module[{\[Beta],\[Gamma],\[Zeta],\[Eta],\[Kappa],\[Lambda],\[Xi],\[Rho],\[Mu],\[Nu]},(g[\[Beta],\[Gamma]]*g[\[Zeta],\[Eta]]*g[\[Kappa],\[Lambda]]*g[\[Mu],\[Nu]]*PDpolar[-\[Alpha]][K[-\[Lambda],-\[Nu]]]*PDpolar[-\[Zeta]][g[-\[Beta],-\[Gamma]]]*PDpolar[-\[Eta]][g[-\[Kappa],-\[Mu]]])/4+g[\[Beta],\[Gamma]]*g[\[Zeta],\[Eta]]*g[\[Kappa],\[Lambda]]*g[\[Mu],\[Nu]]*g[\[Xi],\[Rho]]*K[-\[Beta],-\[Zeta]]*PDpolar[-\[Alpha]][g[-\[Kappa],-\[Mu]]]*PDpolar[-\[Gamma]][g[-\[Lambda],-\[Xi]]]*PDpolar[-\[Eta]][g[-\[Nu],-\[Rho]]]-(g[\[Beta],\[Gamma]]*g[\[Zeta],\[Eta]]*g[\[Kappa],\[Lambda]]*g[\[Mu],\[Nu]]*g[\[Xi],\[Rho]]*K[-\[Beta],-\[Zeta]]*PDpolar[-\[Alpha]][g[-\[Kappa],-\[Mu]]]*PDpolar[-\[Gamma]][g[-\[Lambda],-\[Nu]]]*PDpolar[-\[Eta]][g[-\[Xi],-\[Rho]]])/2-g[\[Beta],\[Gamma]]*g[\[Zeta],\[Eta]]*g[\[Kappa],\[Lambda]]*g[\[Mu],\[Nu]]*K[-\[Beta],-\[Zeta]]*PDpolar[-\[Gamma]][g[-\[Kappa],-\[Mu]]]*PDpolar[-\[Eta]][PDpolar[-\[Alpha]][g[-\[Lambda],-\[Nu]]]]+(g[\[Beta],\[Gamma]]*g[\[Zeta],\[Eta]]*g[\[Kappa],\[Lambda]]*g[\[Mu],\[Nu]]*K[-\[Beta],-\[Zeta]]*PDpolar[-\[Gamma]][g[-\[Kappa],-\[Lambda]]]*PDpolar[-\[Eta]][PDpolar[-\[Alpha]][g[-\[Mu],-\[Nu]]]])/2+(g[\[Beta],\[Gamma]]*g[\[Zeta],\[Eta]]*g[\[Kappa],\[Lambda]]*PDpolar[-\[Alpha]][K[-\[Beta],-\[Zeta]]]*PDpolar[-\[Eta]][PDpolar[-\[Gamma]][g[-\[Kappa],-\[Lambda]]]])/2-(g[\[Beta],\[Gamma]]*g[\[Zeta],\[Eta]]*g[\[Kappa],\[Lambda]]*g[\[Mu],\[Nu]]*K[-\[Beta],-\[Zeta]]*PDpolar[-\[Alpha]][g[-\[Kappa],-\[Mu]]]*PDpolar[-\[Eta]][PDpolar[-\[Gamma]][g[-\[Lambda],-\[Nu]]]])/2+(g[\[Beta],\[Gamma]]*g[\[Zeta],\[Eta]]*g[\[Kappa],\[Lambda]]*K[-\[Beta],-\[Zeta]]*PDpolar[-\[Eta]][PDpolar[-\[Gamma]][PDpolar[-\[Alpha]][g[-\[Kappa],-\[Lambda]]]]])/2+g[\[Beta],\[Gamma]]*g[\[Zeta],\[Eta]]*g[\[Kappa],\[Lambda]]*g[\[Mu],\[Nu]]*g[\[Xi],\[Rho]]*K[-\[Beta],-\[Zeta]]*PDpolar[-\[Alpha]][g[-\[Gamma],-\[Kappa]]]*PDpolar[-\[Eta]][g[-\[Mu],-\[Xi]]]*PDpolar[-\[Lambda]][g[-\[Nu],-\[Rho]]]-(g[\[Beta],\[Gamma]]*g[\[Zeta],\[Eta]]*g[\[Kappa],\[Lambda]]*g[\[Mu],\[Nu]]*g[\[Xi],\[Rho]]*K[-\[Beta],-\[Zeta]]*PDpolar[-\[Alpha]][g[-\[Gamma],-\[Kappa]]]*PDpolar[-\[Eta]][g[-\[Mu],-\[Nu]]]*PDpolar[-\[Lambda]][g[-\[Xi],-\[Rho]]])/2-(g[\[Beta],\[Gamma]]*g[\[Zeta],\[Eta]]*g[\[Kappa],\[Lambda]]*g[\[Mu],\[Nu]]*K[-\[Beta],-\[Zeta]]*PDpolar[-\[Eta]][g[-\[Gamma],-\[Kappa]]]*PDpolar[-\[Lambda]][PDpolar[-\[Alpha]][g[-\[Mu],-\[Nu]]]])/2+(g[\[Beta],\[Gamma]]*g[\[Zeta],\[Eta]]*g[\[Kappa],\[Lambda]]*g[\[Mu],\[Nu]]*K[-\[Beta],-\[Zeta]]*PDpolar[-\[Kappa]][g[-\[Gamma],-\[Eta]]]*PDpolar[-\[Lambda]][PDpolar[-\[Alpha]][g[-\[Mu],-\[Nu]]]])/4-g[\[Beta],\[Gamma]]*g[\[Zeta],\[Eta]]*g[\[Kappa],\[Lambda]]*g[\[Mu],\[Nu]]*K[-\[Beta],-\[Zeta]]*PDpolar[-\[Alpha]][g[-\[Gamma],-\[Kappa]]]*PDpolar[-\[Lambda]][PDpolar[-\[Eta]][g[-\[Mu],-\[Nu]]]]-(g[\[Beta],\[Gamma]]*g[\[Zeta],\[Eta]]*g[\[Kappa],\[Lambda]]*g[\[Mu],\[Nu]]*PDpolar[-\[Alpha]][K[-\[Lambda],-\[Nu]]]*PDpolar[-\[Kappa]][g[-\[Beta],-\[Zeta]]]*PDpolar[-\[Mu]][g[-\[Gamma],-\[Eta]]])/2-(g[\[Beta],\[Gamma]]*g[\[Zeta],\[Eta]]*g[\[Kappa],\[Lambda]]*g[\[Mu],\[Nu]]*PDpolar[-\[Alpha]][K[-\[Lambda],-\[Nu]]]*PDpolar[-\[Zeta]][g[-\[Beta],-\[Gamma]]]*PDpolar[-\[Mu]][g[-\[Eta],-\[Kappa]]])/2+(g[\[Beta],\[Gamma]]*g[\[Zeta],\[Eta]]*g[\[Kappa],\[Lambda]]*g[\[Mu],\[Nu]]*PDpolar[-\[Alpha]][K[-\[Eta],-\[Nu]]]*PDpolar[-\[Zeta]][g[-\[Beta],-\[Gamma]]]*PDpolar[-\[Mu]][g[-\[Kappa],-\[Lambda]]])/4-(g[\[Beta],\[Gamma]]*g[\[Zeta],\[Eta]]*g[\[Kappa],\[Lambda]]*g[\[Mu],\[Nu]]*K[-\[Beta],-\[Zeta]]*PDpolar[-\[Eta]][PDpolar[-\[Alpha]][g[-\[Gamma],-\[Nu]]]]*PDpolar[-\[Mu]][g[-\[Kappa],-\[Lambda]]])/2+(g[\[Beta],\[Gamma]]*g[\[Zeta],\[Eta]]*g[\[Kappa],\[Lambda]]*g[\[Mu],\[Nu]]*g[\[Xi],\[Rho]]*K[-\[Beta],-\[Zeta]]*PDpolar[-\[Alpha]][g[-\[Kappa],-\[Mu]]]*PDpolar[-\[Eta]][g[-\[Gamma],-\[Lambda]]]*PDpolar[-\[Nu]][g[-\[Xi],-\[Rho]]])/2+(g[\[Beta],\[Gamma]]*g[\[Zeta],\[Eta]]*g[\[Kappa],\[Lambda]]*g[\[Mu],\[Nu]]*g[\[Xi],\[Rho]]*K[-\[Beta],-\[Zeta]]*PDpolar[-\[Alpha]][g[-\[Gamma],-\[Kappa]]]*PDpolar[-\[Eta]][g[-\[Lambda],-\[Mu]]]*PDpolar[-\[Nu]][g[-\[Xi],-\[Rho]]])/2-(g[\[Beta],\[Gamma]]*g[\[Zeta],\[Eta]]*g[\[Kappa],\[Lambda]]*g[\[Mu],\[Nu]]*g[\[Xi],\[Rho]]*K[-\[Beta],-\[Zeta]]*PDpolar[-\[Alpha]][g[-\[Kappa],-\[Mu]]]*PDpolar[-\[Lambda]][g[-\[Gamma],-\[Eta]]]*PDpolar[-\[Nu]][g[-\[Xi],-\[Rho]]])/4+(g[\[Beta],\[Gamma]]*g[\[Zeta],\[Eta]]*g[\[Kappa],\[Lambda]]*g[\[Mu],\[Nu]]*g[\[Xi],\[Rho]]*K[-\[Beta],-\[Zeta]]*PDpolar[-\[Alpha]][g[-\[Gamma],-\[Kappa]]]*PDpolar[-\[Lambda]][g[-\[Eta],-\[Mu]]]*PDpolar[-\[Nu]][g[-\[Xi],-\[Rho]]])/2-(g[\[Beta],\[Gamma]]*g[\[Zeta],\[Eta]]*g[\[Kappa],\[Lambda]]*g[\[Mu],\[Nu]]*g[\[Xi],\[Rho]]*K[-\[Beta],-\[Zeta]]*PDpolar[-\[Alpha]][g[-\[Gamma],-\[Kappa]]]*PDpolar[-\[Mu]][g[-\[Eta],-\[Lambda]]]*PDpolar[-\[Nu]][g[-\[Xi],-\[Rho]]])/2+(g[\[Beta],\[Gamma]]*g[\[Zeta],\[Eta]]*g[\[Kappa],\[Lambda]]*g[\[Mu],\[Nu]]*K[-\[Beta],-\[Zeta]]*PDpolar[-\[Mu]][g[-\[Kappa],-\[Lambda]]]*PDpolar[-\[Nu]][PDpolar[-\[Alpha]][g[-\[Gamma],-\[Eta]]]])/4+(g[\[Beta],\[Gamma]]*g[\[Zeta],\[Eta]]*g[\[Kappa],\[Lambda]]*g[\[Mu],\[Nu]]*g[\[Xi],\[Rho]]*K[-\[Beta],-\[Zeta]]*PDpolar[-\[Alpha]][g[-\[Kappa],-\[Mu]]]*PDpolar[-\[Eta]][g[-\[Gamma],-\[Xi]]]*PDpolar[-\[Rho]][g[-\[Lambda],-\[Nu]]])/2-(g[\[Beta],\[Gamma]]*g[\[Zeta],\[Eta]]*g[\[Kappa],\[Lambda]]*g[\[Mu],\[Nu]]*g[\[Xi],\[Rho]]*K[-\[Beta],-\[Zeta]]*PDpolar[-\[Alpha]][g[-\[Kappa],-\[Mu]]]*PDpolar[-\[Xi]][g[-\[Gamma],-\[Eta]]]*PDpolar[-\[Rho]][g[-\[Lambda],-\[Nu]]])/4];


(* ::Section:: *)
(*Evaluation*)


MyImport[platform_, file_]:= Module[{path, a},If[platform == "Linux", path = "/home/matthew/Dropbox/Vacio/Mannheim/output/", path = "C:/Users/mgp/Dropbox/Vacio/Mannheim/output/"]; ToExpression[Evaluate[Import[StringJoin[path,file]]]]]


(*MyImport["Linuxx","new_gauge/test.txt"];*)


MyExport[platform_, destination_, expr_]:= Module[{path},If[platform == "Linux", path = "/home/matthew/Dropbox/Vacio/Mannheim/output/", path = "C:/Users/mgp/Dropbox/Vacio/Mannheim/output/"]; 
Export[StringJoin[path,destination],Evaluate[ToString[Evaluate[expr//InputForm]]],"List"]];


length[expr_]:= Length[expr/.{List->Plus}];


show[expr_,n_]:= Take[List@@expr,n];


dwg[-\[Mu]_,-\[Nu]_]:= Module[{\[Alpha],\[Beta],\[Gamma],\[Zeta]},(g[\[Alpha],\[Beta]]*g[-\[Mu],-\[Nu]]*CD[-\[Beta]][CD[-\[Alpha]][AA[]]])/6-(g[\[Alpha],\[Beta]]*CD[-\[Beta]][CD[-\[Alpha]][CD[-\[Mu]][A[-\[Nu]]]]])/2-(g[\[Alpha],\[Beta]]*CD[-\[Beta]][CD[-\[Alpha]][CD[-\[Nu]][A[-\[Mu]]]]])/2+(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Zeta]]*CD[-\[Zeta]][CD[-\[Gamma]][CD[-\[Beta]][CD[-\[Alpha]][K[-\[Mu],-\[Nu]]]]]])/2+CD[-\[Nu]][CD[-\[Mu]][AA[]]]/3];


dwgnobox[-\[Mu]_,-\[Nu]_]:=Module[{\[Alpha],\[Beta]},(g[\[Alpha],\[Beta]]*g[-\[Mu],-\[Nu]]*CD[-\[Beta]][CD[-\[Alpha]][AA[]]])/6-(g[\[Alpha],\[Beta]]*CD[-\[Beta]][CD[-\[Alpha]][CD[-\[Mu]][A[-\[Nu]]]]])/2-(g[\[Alpha],\[Beta]]*CD[-\[Beta]][CD[-\[Alpha]][CD[-\[Nu]][A[-\[Mu]]]]])/2+CD[-\[Nu]][CD[-\[Mu]][AA[]]]/3];


Asub = {A[\[Mu]_]:> Module[{\[Alpha],\[Rho],\[Sigma],\[Nu]}, 1/2g[\[Nu],\[Alpha]]K[-\[Alpha],\[Mu]]g[\[Rho],\[Sigma]]PD[-\[Nu]][g[-\[Rho],-\[Sigma]]]]};


AAsub = {AA[]:>Module[{\[Alpha],\[Beta],\[Gamma],\[Zeta],\[Eta],\[Kappa],\[Lambda],\[Mu]},-g[\[Alpha],\[Beta]]*g[\[Gamma],\[Zeta]]*g[\[Eta],\[Kappa]]*g[\[Lambda],\[Mu]]*K[-\[Alpha],-\[Gamma]]*PD[-\[Beta]][g[-\[Eta],-\[Lambda]]]*PD[-\[Zeta]][g[-\[Kappa],-\[Mu]]]/2+(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Zeta]]*g[\[Eta],\[Kappa]]*g[\[Lambda],\[Mu]]*K[-\[Alpha],-\[Gamma]]*PD[-\[Beta]][g[-\[Eta],-\[Kappa]]]*PD[-\[Zeta]][g[-\[Lambda],-\[Mu]]])/4+(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Zeta]]*g[\[Eta],\[Kappa]]*K[-\[Alpha],-\[Gamma]]*PD[-\[Zeta]][PD[-\[Beta]][g[-\[Eta],-\[Kappa]]]])/2-(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Zeta]]*g[\[Eta],\[Kappa]]*g[\[Lambda],\[Mu]]*K[-\[Alpha],-\[Gamma]]*PD[-\[Zeta]][g[-\[Beta],-\[Eta]]]*PD[-\[Kappa]][g[-\[Lambda],-\[Mu]]])/2+(g[\[Alpha],\[Beta]]*g[\[Gamma],\[Zeta]]*g[\[Eta],\[Kappa]]*g[\[Lambda],\[Mu]]*K[-\[Alpha],-\[Gamma]]*PD[-\[Eta]][g[-\[Beta],-\[Zeta]]]*PD[-\[Kappa]][g[-\[Lambda],-\[Mu]]])/4]};


ParallelToCanonical[expr_,n_]:=Module[{},ParallelMap[ToCanonical[Plus@@#]&,Partition[Quiet[PadRight[List@@(SameDummies[expr//Expand]),(Quotient[Length[(SameDummies[expr//Expand])],n]+1)*n]],n]]];


ParallelToCanonical2[expr_]:=Plus@@ParallelMap[ToCanonical[#]&,List@@(SameDummies[expr//Expand])];


ToPD[expr_]:= Expand[ChangeCovD[expr,CD,PD]//ChristoffelToMetric];


(* ::Section::Closed:: *)
(*Other*)


(*benchplotrun = AbsoluteTiming[benchplotdata[3,2]];*)


(*ListPlot[benchplotrun[[2]],PlotLegends->Table[StringJoin["n=",ToString[n]],{n,1,8}],Joined\[Rule]True,AxesLabel\[Rule]{"Number of Terms","Time (s)"},PlotMarkers\[Rule]Automatic]*)


(*Export["C:/Users/mgp/Dropbox/Vacio/Mannheim/hpc/bench.pdf",%]*)


(* ::Section:: *)
(*Benchmarking*)


Write[s,"Post-Initialization Completed"]


term5b = CD[-\[Nu]][CD[-\[Mu]][AA[]]]/3;


term5c= ScreenDollarIndices[SameDummies[Expand[ToPD[term5b]/.AAsub]]];


Write[s,"Term 5c evaluated"]


term5test[i_,n_]:=  (* make i>1 *)AbsoluteTiming[Plus@@ParallelToCanonical[SameDummies[Expand[(Plus@@term5c[[1;;i]])/.AAsub]],n]];


sterm5test[i_,n_]:=  (* make i>1 *)AbsoluteTiming[ToCanonical[SameDummies[Expand[(Plus@@term5c[[1;;i]])/.AAsub]]]];


benchdata[i_,n_]:=Table[{ii,term5test[ii,nn][[1]],nn},{nn,1,n},{ii,2,i}];


benchplotdata[i_,n_]:= Module[{benchdata0},benchdata0=benchdata[i,n];Table[Transpose[{benchdata0[[nn,All]][[All,1]],benchdata0[[nn,All]][[All,2]]}],{nn,1,n}]];


mybenchplot[i_,n_]:= {i,term5test[i,n][[1]]};


smybenchplot[i_,n_]:= {i,sterm5test[i,n][[1]]};


(*plot =ListPlot[{{mybenchplot[100,1],mybenchplot[160,1]},{mybenchplot[100,2],mybenchplot[160,2]},{mybenchplot[100,3],mybenchplot[160,3]},{mybenchplot[100,4],mybenchplot[160,4]}},PlotLegends\[Rule](StringJoin["n=",ToString[#]]&/@{1,2,3,4}),Joined\[Rule]True,AxesLabel\[Rule]{"Number of Terms","Time (s)"},PlotMarkers\[Rule]Automatic]*)


Write[s,"Pre-result"]


result = AbsoluteTiming[ParallelToCanonical2[term5c]];


Write[s,"Result Calculated"]


Export["/home/map14010/result1.txt",result[[1]]];


Export["/home/map14010/result2.txt",result[[2]]];


Close[s]


CloseKernels[];


Exit[];


Quit
