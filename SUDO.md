# Sudo: Quickstart

The _s_ubstance _u_se _d_isorders _o_ntology provides a structured vocabulary to describe clinical trials to treat substance use disorders. _sudo_ 1.0 only covers research on treating opioid misuse disorders. In developing sudo we prefer breadth over depth. The goal for sudo 1.0 is to develop an ontology that captures enough important features of clinical trials listed on NIDA DataShare to answer clinician's questions. Some of the ontologic representations, accordingly, are composites. We will reduce those composites to atoms and axioms in later versions. This approach is similar to [something about linguistic trees here].

## Representation of Clinical Trial Information. 
Sudo builds off the PICO (_P_opulation _I_intervention _C_omparison _O_utcome) framework for describing clinical trials. Sudo represents each of these elements with a specification, PopulationSpecification, InteverntionSpecification, ComparisonSpecification, and OutcomeSpecification. 

### PopulationSpecification 
This element contains those elements that specify the group of people on whom the study was performed. We divide PopulationSpecification into Enrollment and Allocation. This division reflects the CONSORT strucure for reporting clinical trials. It also respects Basic Formal Ontology. An Enrollment is a Partition (generic dependent continuant) between those included in the study and those not included in the study. An Allocation is a Partition between those included in one part of the study but not another. Neither parition is static. A person who is enrolled may leave the study. In a cross-over study a subject allocated to one arm at one point in time may be allocated to another arm at a second point in time. 

#### Enrollment
An Enrollment is a partition among the general population into those included in the study when the study begins and those not included. We divide Enrollment into two mutually exclusive categories, InclusionCriterionSet and ExclusionCriterionSet. 
1. The InclusionCriterionSet contains all InclusionCriteria. Each InclusionCriterion is a characteristic of a subject that if present 
1. The analogous ExclusionCriterionSet

#### AllocationSet
In contrast to Enrollment, the immediate descendant of PopulationSpecification is not Allocation but AllocationSet. (Future versions of sudo may redefine Enrollment to keep parallelism.) An Allocation is a partition among the study population so that each group defined by this partition recieves exactly one intervention at each point in time. 

Each Allocation has the following fields (slots):
1. AllocationType: This refers to the statistics method used to allocate people between the defined partitions. (Future versions of sudo may rename this from AllocationType to Allocation Method). The AllocationType usually has the value Random, although other values such as Block-design are possible.

####AllocatedStudyArm
The AllocatedStudyArm is the realization of the application of an AllocationSet to a group of people. 
