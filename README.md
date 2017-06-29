# experiment-definitions

Definitions of AGIEF experiments. All experiments can be repeated from these.
The experiments and terminology is explained below:

--- April 2017

We are comparing unsupervised algorithms by running a two stage experiment.

* Phase 1 = unsupervised algorithm on MNIST 
* Phase 2 = supervised algorithm (logistic regression) on the features produced by Phase 1

**Phase 1 unsupervised algorithms consist of:**

* mnist-ksparse
* mnist-online-ksparse-ph1
* mnist-online-ksparse-real
* mnist-quilted-gng

**Phase 2 - Logistic Regression stage consists of:**

* mnist-classify-features


NOTE: When running phase 2, you need to point Phase 2 data structures (in data.json) at the Phase 1 output data structures.
This is done by specifying the Phase 1 prefixed data.json in experiments.json, and the specific entities in the Phase 2 data.json. There is a script in mnist-classify-features called ```runexp.sh``` that does this for you, provided that the PASTASAUCE prefix template is specified where necessary in experiments.json and data.json.


**Terminology**

experiment: 		: a set of ‘experiment runs’
experiment-run	: a simulation for a given set of parameter values

**Experiment-Definitions Description**

Contains the description and state for an experiment.
The output/results are never committed back to the repo, but rather uploaded to S3 by run-framework

**Background**

Entity.json and data.json completely define the state of the system, before or after any number of iterations. 
So it can be used to define a bunch of entities such as K-Sparse unsupervised learning.

There are Java Demo classes, that define this in code. We load them, don’t conduct ANY iterations, but export the state as entity.json and data.json, and that forms the starting point for future experiments.

This can be done with run-framework (with --step_gen_input)
This is only required for new experiments.

**Experiment-Definitions folder structure**

* /experiment-name (folder)
	* experiments.json	: starting point for an exp, defines what will take place
	* log4j2.xml		: configuration file for logging
	* node.properties	: some properties for Compute (java server)
	* /input (folder)	
		* entity.json	: the entity tree to be simulated
		* data.json 		: the whole state of experiment, all the data structures
		* [prefix]entity.json	: auto generated by run-framework for THIS experiment-run 
		* [prefix]data.json 	: auto generated by run-framework for THIS experiment-run
	* /output (folder)		:
		* [prefix]entity.json	: exported or saved by run-framework for THIS experiment-run 
   		* [prefix]data.json 	: exported or saved by run-framework for THIS experiment-run

**Debugging**

If age is not incrementing (after a few minutes), go to Loggly, stderr should’ve been logged.
