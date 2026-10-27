* Multilevel Modeling

	display "`c(pwd)'"
		* If the display "`c(pwd)'" code above is not the folderwhere you opened the .do file, 
		* then click File-->Change working directory...-->and then select the folder where this .do file is located.

	* Results: "Participants Learned Reinforcement Contingencies Appropriately"

		* True OS and PR Control
		
			import delimited "`c(pwd)'/OS_Transfer_Exp_Acquisition_Reminder1_2.csv", clear
				
			* Define label for transfertraining
			label define transfer_lbl 1 "Generalization" 2 "Ambiguous" 3 "Specificity"
			label values transfertraining transfer_lbl

			* Define label for hierarchicaltraining
			label define hierarchical_lbl 0 "PR Control" 1 "True OS"
			label values hierarchicaltraining hierarchical_lbl
			
			* Define label for stimulus
			label define stimulus_lbl 0 "Non-Reinforced" 1 "Reinforced" 2 "OS_Alone_Non-Reinforced"
			label values stimulus stimulus_lbl
			
			mixed dv i.transfertraining##i.hierarchicaltraining##i.stimulus##c.trial##c.trial || id:
			contrast i.transfertraining##i.hierarchicaltraining##i.stimulus
			margins, dydx(c.trial)
			contrast i.transfertraining#i.hierarchicaltraining#i.stimulus#c.trial#c.trial
			contrast i.transfertraining#i.hierarchicaltraining#i.stimulus#c.trial
			contrast i.transfertraining#i.stimulus#c.trial#c.trial
			contrast i.transfertraining#i.stimulus#c.trial
			contrast i.hierarchicaltraining#i.stimulus#c.trial#c.trial
			contrast i.hierarchicaltraining#i.stimulus#c.trial
			
				margins i.hierarchicaltraining#i.stimulus, dydx(trial) at(trial=0)
				margins i.hierarchicaltraining#i.stimulus, dydx(trial) at(trial=0) pwcompare(pveffects)

			* Test whether the stimulus-by-trial slope differs between PR Control and True OS
			test 1.hierarchicaltraining#1.stimulus#c.trial = 0.hierarchicaltraining#1.stimulus#c.trial
			
			* Trial 10 and 12 (Reminder 1_2 and 2_2)
			
				mixed dv i.transfertraining##i.hierarchicaltraining##i.stimulus if trial == 10 || id:
				contrast i.transfertraining##i.hierarchicaltraining##i.stimulus
				
					margins i.hierarchicaltraining#i.stimulus, pwcompare(pveffects)
				
				mixed dv i.transfertraining##i.hierarchicaltraining##i.stimulus if trial == 12 || id:
				contrast i.transfertraining##i.hierarchicaltraining##i.stimulus
				
					margins i.hierarchicaltraining#i.stimulus, pwcompare(pveffects)
	
	* Results: "Extinction" and "Occasion Setting Was Learned in the True Occasion Setting Condition,
	* and CS Partial Reinforcement Was Learned in the Partial Reinforcement Control Condition"
	
		* ext_alpha
		
			import delimited "`c(pwd)'/OS_Transfer_Exp_Ext_Alpha_V0.csv", clear
			
			* Define label for transfertraining
			label define transfer_lbl 1 "Generalization" 2 "Ambiguous" 3 "Specificity"
			label values transfertraining transfer_lbl

			* Define label for hierarchicaltraining
			label define hierarchical_lbl 0 "PR Control" 1 "True OS"
			label values hierarchicaltraining hierarchical_lbl
			
			mixed ext_alpha i.transfertraining##i.hierarchicaltraining
			contrast i.transfertraining##i.hierarchicaltraining
			
				margins i.transfertraining##i.hierarchicaltraining
				margins i.transfertraining##i.hierarchicaltraining, pwcompare(pveffects)
		
		* ext_alpha controlling for ext_intercept
		
			import delimited "`c(pwd)'/OS_Transfer_Exp_Ext_Alpha_V0.csv", clear
			
			* Define label for transfertraining
			label define transfer_lbl 1 "Generalization" 2 "Ambiguous" 3 "Specificity"
			label values transfertraining transfer_lbl

			* Define label for hierarchicaltraining
			label define hierarchical_lbl 0 "PR Control" 1 "True OS"
			label values hierarchicaltraining hierarchical_lbl
			
			mixed ext_alpha ext_intercept i.transfertraining##i.hierarchicaltraining
			contrast i.transfertraining##i.hierarchicaltraining
			
				margins i.transfertraining##i.hierarchicaltraining
				margins i.transfertraining##i.hierarchicaltraining, pwcompare(pveffects)
	
		* Cognitive Learning - 50% PR, Modulation, Configuration

			import delimited "`c(pwd)'/OS_Transfer_Latent_Learning.csv", clear
			drop ratingwording orderversion stimulusversion date
			drop if stimulus > 3

			* Define label for transfertraining
			label define transfer_lbl 1 "Generalization" 2 "Ambiguous" 3 "Specificity"
			label values transfertraining transfer_lbl

			* Define label for hierarchicaltraining
			label define hierarchical_lbl 0 "PR Control" 1 "True OS"
			label values hierarchicaltraining hierarchical_lbl
			
			* Define label for stimulus
			label define stimulus_lbl 1 "50% PR" 2 "Mod" 3 "Config" 4 "Direct_CS" 5 "Direct_OS" 6 "General" 7 "Specific"
			label values stimulus stimulus_lbl


			mixed dv i.transfertraining##i.hierarchicaltraining##i.stimulus || id:

			contrast i.transfertraining##i.hierarchicaltraining##i.stimulus

				margins i.hierarchicaltraining#i.stimulus, pwcompare(pveffects)
				margins i.transfertraining#i.hierarchicaltraining#i.stimulus, pwcompare(pveffects)

	* Results: "Occasion Setting Can Produce Varying Degrees of Transfer as Expected, Ranging from Full to Low Transfer"
	
		* Difference score - Trained minus Transfer
		
			import delimited "`c(pwd)'/OS_Transfer_Exp_Test1_TrainedTransferDiff.csv", clear
			drop if hierarchicaltraining == 0
			
			* Define label for transfertraining
			label define transfer_lbl 1 "Generalization" 2 "Ambiguous" 3 "Specificity"
			label values transfertraining transfer_lbl

			* Define label for hierarchicaltraining
			label define hierarchical_lbl 0 "PR Control" 1 "True OS"
			label values hierarchicaltraining hierarchical_lbl
			
			mixed dv i.transfertraining
			contrast i.transfertraining
			
				margins i.transfertraining
				margins i.transfertraining, pwcompare(pveffects)
				
		* Hypothesis 3b - Within each TransferTraining, test if Trained minus Transfer differs between True OS and PR Control
		
			* Difference score - Trained minus Transfer
			
				import delimited "`c(pwd)'/OS_Transfer_Exp_Test1_TrainedTransferDiff.csv", clear
				
				* Define label for transfertraining
				label define transfer_lbl 1 "Generalization" 2 "Ambiguous" 3 "Specificity"
				label values transfertraining transfer_lbl

				* Define label for hierarchicaltraining
				label define hierarchical_lbl 0 "PR Control" 1 "True OS"
				label values hierarchicaltraining hierarchical_lbl
				
				mixed dv i.transfertraining##i.hierarchicaltraining
				contrast i.transfertraining##i.hierarchicaltraining
				
					margins i.transfertraining#i.hierarchicaltraining
					margins i.transfertraining#i.hierarchicaltraining, pwcompare(pveffects)

	* Results: "Occasion Setting Can Produce Varying Degrees of Beliefs Regarding
	* Generalization and Specificity of Transferability of Occasion Setters to CSs"

		* Retaining General and Specific Values
	
			import delimited "`c(pwd)'/OS_Transfer_Latent_Learning.csv", clear
			drop ratingwording orderversion stimulusversion date
			drop if hierarchicaltraining == 0
			drop if stimulus < 6

			* Define label for transfertraining
			label define transfer_lbl 1 "Generalization" 2 "Ambiguous" 3 "Specificity"
			label values transfertraining transfer_lbl

			* Define label for hierarchicaltraining
			label define hierarchical_lbl 0 "PR Control" 1 "True OS"
			label values hierarchicaltraining hierarchical_lbl
			
			* Define label for stimulus
			label define stimulus_lbl 1 "50% PR" 2 "Mod" 3 "Config" 4 "Direct_CS" 5 "Direct_OS" 6 "General" 7 "Specific"
			label values stimulus stimulus_lbl

			mixed dv i.transfertraining##i.hierarchicaltraining##i.stimulus || id:

			contrast i.transfertraining##i.stimulus

				margins i.stimulus#i.transfertraining, pwcompare(pveffects)
	
		* Difference score - General minus Specific
		
			import delimited "`c(pwd)'/OS_Transfer_Latent_Learning_GenMinusSpec.csv", clear
			drop if hierarchicaltraining == 0
			
			* Define label for transfertraining
			label define transfer_lbl 1 "Generalization" 2 "Ambiguous" 3 "Specificity"
			label values transfertraining transfer_lbl

			* Define label for hierarchicaltraining
			label define hierarchical_lbl 0 "PR Control" 1 "True OS"
			label values hierarchicaltraining hierarchical_lbl
			
			mixed dv i.transfertraining
			contrast i.transfertraining
			
				margins i.transfertraining
				margins i.transfertraining, pwcompare(pveffects)				
			
	* Results: "The Specific Occasion Setter / CS Combination and Possibly the CS that Underwent the Extinction Procedure Were Extinguished"
	
		import delimited "`c(pwd)'/OS_Transfer_Exp_Test1_2_Diff.csv", clear
			
		* Define label for transfertraining
		label define transfer_lbl 1 "Generalization" 2 "Ambiguous" 3 "Specificity"
		label values transfertraining transfer_lbl

		* Define label for hierarchicaltraining
		label define hierarchical_lbl 0 "PR Control" 1 "True OS"
		label values hierarchicaltraining hierarchical_lbl
		
		drop if hierarchicaltraining == 0
// 		drop if transfertraining == 3
		
			// Create a numeric variable manually
			gen stimulus_num = .

			replace stimulus_num = 1 if stimulus == "Ax"
			replace stimulus_num = 2 if stimulus == "Ay"
			replace stimulus_num = 3 if stimulus == "Bx"
			replace stimulus_num = 4 if stimulus == "By"
			replace stimulus_num = 5 if stimulus == "Cz"
			replace stimulus_num = 6 if stimulus == "Az"
			replace stimulus_num = 7 if stimulus == "Bz"
			replace stimulus_num = 8 if stimulus == "Cx"
			replace stimulus_num = 9 if stimulus == "Cy"

			// Define the label
			label define stimlabel 1 "Ax" 2 "Ay" 3 "Bx" 4 "By" 5 "Cz" 6 "Az" 7 "Bz" 8 "Cx" 9 "Cy"

			// Apply it
			label values stimulus_num stimlabel
			
			// Drop original string variable and rename the numeric one
			drop stimulus
			rename stimulus_num stimulus
			
			drop if stimulus > 4

			
		mixed dv i.transfertraining##i.stimulus || id:
		contrast i.transfertraining##i.stimulus
		
			margins i.transfertraining#i.stimulus
			
			quietly display "=================="
			quietly display "Generalization Training"
			quietly display "=================="
			margins stimulus if transfertraining == 1, pwcompare(pveffects)
			
			quietly display "=================="
			quietly display "Ambiguous Training"
			quietly display "=================="
			margins stimulus if transfertraining == 2, pwcompare(pveffects)
			
			quietly display "=================="
			quietly display "Specificity Training"
			quietly display "=================="
			margins stimulus if transfertraining == 3, pwcompare(pveffects)
			
		* Does Generalization Ax minus By differ from Ambiguous Ax minus By
		
			test (1.transfertraining#4.stimulus - 1.transfertraining#1.stimulus) = ///
		     (2.transfertraining#4.stimulus - 2.transfertraining#1.stimulus)
			
		* Does Specificity Ax minus By differ from Generalization Ax minus By
			test (3.transfertraining#4.stimulus - 3.transfertraining#1.stimulus) = ///
				 (1.transfertraining#4.stimulus - 1.transfertraining#1.stimulus)

		* Does Specificity Ax minus By differ from Ambiguous Ax minus By
			test (3.transfertraining#4.stimulus - 3.transfertraining#1.stimulus) = ///
				 (2.transfertraining#4.stimulus - 2.transfertraining#1.stimulus)
