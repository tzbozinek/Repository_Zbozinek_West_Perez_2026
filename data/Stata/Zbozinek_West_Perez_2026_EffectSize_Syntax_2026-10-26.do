* Effect Size Syntax

display "`c(pwd)'"
	* If the display "`c(pwd)'" code above is not the folderwhere you opened the .do file, 
	* then click File-->Change working directory...-->and then select the folder where this .do file is located.

*** Participants Learned Reinforcement Contingencies Appropriately

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
	
	*hierarchicaltraining*stimulus*trial (Quadratic in Quadratic Model)
				
		meglm dv i.stimulus c.trial i.hierarchicaltraining ///
				i.stimulus#c.trial i.stimulus#i.hierarchicaltraining c.trial#i.hierarchicaltraining ///
				i.stimulus#c.trial#i.hierarchicaltraining ///
				c.trial#c.trial ///
				i.stimulus#c.trial#c.trial i.stimulus#i.hierarchicaltraining c.trial#c.trial#i.hierarchicaltraining i.transfertraining#i.hierarchicaltraining ///
				i.stimulus#c.trial#c.trial#i.transfertraining i.stimulus#c.trial#c.trial#i.hierarchicaltraining i.stimulus#i.transfertraining#i.hierarchicaltraining c.trial#c.trial#i.transfertraining#i.hierarchicaltraining ///
				i.stimulus#c.trial#c.trial#i.transfertraining#i.hierarchicaltraining || id:

		matrix ab=e(b)
		matrix list ab

		*change brackets to match where "var(e.dv)" is (where "dv" is the name of the dv). This should also match the number of columns.
		global Vab = ab[1,95]

		*change "id" to be whatever the variable is for participants' ids
		*change brackets so that it reflects the column number for "var(_cons~)" (i.e., [1,X]
		constraint 1 _b[/var(_cons[id])]= ab[1,94]
		
		*This is the same as the meglm above except this one contains ", coeflegend" at the end
		meglm dv i.stimulus c.trial i.hierarchicaltraining ///
				i.stimulus#c.trial i.stimulus#i.hierarchicaltraining c.trial#i.hierarchicaltraining ///
				i.stimulus#c.trial#i.hierarchicaltraining ///
				c.trial#c.trial ///
				i.stimulus#c.trial#c.trial i.stimulus#i.hierarchicaltraining c.trial#c.trial#i.hierarchicaltraining i.transfertraining#i.hierarchicaltraining ///
				i.stimulus#c.trial#c.trial#i.transfertraining i.stimulus#c.trial#c.trial#i.hierarchicaltraining i.stimulus#i.transfertraining#i.hierarchicaltraining c.trial#c.trial#i.transfertraining#i.hierarchicaltraining ///
				i.stimulus#c.trial#c.trial#i.transfertraining#i.hierarchicaltraining || id:, coeflegend

		*Remove the main effect or interaction for which you want to know the effect size
		*If this worked correctly, you will see "constrained" in the "id var(_cons)" and "Std. Err." cell
		meglm dv i.stimulus c.trial i.hierarchicaltraining ///
				i.stimulus#c.trial i.stimulus#i.hierarchicaltraining c.trial#i.hierarchicaltraining ///
				i.stimulus#c.trial#i.hierarchicaltraining ///
				c.trial#c.trial ///
				i.stimulus#c.trial#c.trial i.stimulus#i.hierarchicaltraining c.trial#c.trial#i.hierarchicaltraining i.transfertraining#i.hierarchicaltraining ///
				i.stimulus#c.trial#c.trial#i.transfertraining i.stimulus#c.trial#c.trial#i.hierarchicaltraining i.stimulus#i.transfertraining#i.hierarchicaltraining c.trial#c.trial#i.transfertraining#i.hierarchicaltraining || id:, constraints(1)

		matrix a = e(b)
		matrix li a

		*change brackets to match where "var(e.dv)" is (where "dv" is the name of the dv). This should also match the number of columns.
		global Va = a[1,77]
			
		*Empty model - remove all predictors
		*If this worked correctly, you will see "constrained" in the "id var(_cons)" and "Std. Err." cell
		meglm dv || id:, constraints(1)

		matrix null=e(b)
		matrix list null
		*change brackets to match where "var(e.dv)" is (where "dv" is the name of the dv). This should also match the number of columns.
		global Vnull = null[1,3]

		global R2ab = ($Vnull - $Vab)/$Vnull
		global R2a = ($Vnull - $Va)/$Vnull

		display "Proportion explained full model = $R2ab"
		display "Proportion explained reduced model = $R2a"

		global f2b = ($R2ab - $R2a)/(1-$R2ab)
		display "Effect size f2 = $f2b"
			
		global fb = sqrt(($R2ab - $R2a)/(1-$R2ab))
		display "Effect size f = $fb"
				
	*hierarchicaltraining*stimulus*trial (Linear in Linear Model)
				
		meglm dv i.stimulus c.trial i.hierarchicaltraining ///
				i.stimulus#c.trial i.stimulus#i.hierarchicaltraining c.trial#i.hierarchicaltraining ///
				i.stimulus#c.trial#i.hierarchicaltraining || id:

		matrix ab=e(b)
		matrix list ab

		*change brackets to match where "var(e.dv)" is (where "dv" is the name of the dv). This should also match the number of columns.
		global Vab = ab[1,26]

		*change "id" to be whatever the variable is for participants' ids
		*change brackets so that it reflects the column number for "var(_cons~)" (i.e., [1,X]
		constraint 1 _b[/var(_cons[id])]= ab[1,25]
		
		*This is the same as the meglm above except this one contains ", coeflegend" at the end
		meglm dv i.stimulus c.trial i.hierarchicaltraining ///
				i.stimulus#c.trial i.stimulus#i.hierarchicaltraining c.trial#i.hierarchicaltraining ///
				i.stimulus#c.trial#i.hierarchicaltraining || id:, coeflegend

		*Remove the main effect or interaction for which you want to know the effect size
		*If this worked correctly, you will see "constrained" in the "id var(_cons)" and "Std. Err." cell
		meglm dv i.stimulus c.trial i.hierarchicaltraining ///
				i.stimulus#c.trial i.stimulus#i.hierarchicaltraining c.trial#i.hierarchicaltraining || id:, constraints(1)

		matrix a = e(b)
		matrix li a

		*change brackets to match where "var(e.dv)" is (where "dv" is the name of the dv). This should also match the number of columns.
		global Va = a[1,20]
			
		*Empty model - remove all predictors
		*If this worked correctly, you will see "constrained" in the "id var(_cons)" and "Std. Err." cell
		meglm dv || id:, constraints(1)

		matrix null=e(b)
		matrix list null
		*change brackets to match where "var(e.dv)" is (where "dv" is the name of the dv). This should also match the number of columns.
		global Vnull = null[1,3]

		global R2ab = ($Vnull - $Vab)/$Vnull
		global R2a = ($Vnull - $Va)/$Vnull

		display "Proportion explained full model = $R2ab"
		display "Proportion explained reduced model = $R2a"

		global f2b = ($R2ab - $R2a)/(1-$R2ab)
		display "Effect size f2 = $f2b"
			
		global fb = sqrt(($R2ab - $R2a)/(1-$R2ab))
		display "Effect size f = $fb"
		
	*hierarchicaltraining*stimulus*trial@10 (Last trial of Reminder 1 (trial 10) in Linear Model)
				
		drop if trial < 10
		drop if trial > 10
		
		meglm dv i.stimulus i.hierarchicaltraining ///
				i.stimulus#i.hierarchicaltraining || id:

		matrix ab=e(b)
		matrix list ab

		*change brackets to match where "var(e.dv)" is (where "dv" is the name of the dv). This should also match the number of columns.
		global Vab = ab[1,13]

		*change "id" to be whatever the variable is for participants' ids
		*change brackets so that it reflects the column number for "var(_cons~)" (i.e., [1,X]
		constraint 1 _b[/var(_cons[id])]= ab[1,12]
		
		*This is the same as the meglm above except this one contains ", coeflegend" at the end
		meglm dv i.stimulus i.hierarchicaltraining ///
				i.stimulus#i.hierarchicaltraining || id:, coeflegend

		*Remove the main effect or interaction for which you want to know the effect size
		*If this worked correctly, you will see "constrained" in the "id var(_cons)" and "Std. Err." cell
		meglm dv i.stimulus i.hierarchicaltraining || id:, constraints(1)

		matrix a = e(b)
		matrix li a

		*change brackets to match where "var(e.dv)" is (where "dv" is the name of the dv). This should also match the number of columns.
		global Va = a[1,8]
			
		*Empty model - remove all predictors
		*If this worked correctly, you will see "constrained" in the "id var(_cons)" and "Std. Err." cell
		meglm dv || id:, constraints(1)

		matrix null=e(b)
		matrix list null
		*change brackets to match where "var(e.dv)" is (where "dv" is the name of the dv). This should also match the number of columns.
		global Vnull = null[1,3]

		global R2ab = ($Vnull - $Vab)/$Vnull
		global R2a = ($Vnull - $Va)/$Vnull

		display "Proportion explained full model = $R2ab"
		display "Proportion explained reduced model = $R2a"

		global f2b = ($R2ab - $R2a)/(1-$R2ab)
		display "Effect size f2 = $f2b"
			
		global fb = sqrt(($R2ab - $R2a)/(1-$R2ab))
		display "Effect size f = $fb"
	
	
	*hierarchicaltraining*stimulus*trial@12 (Last trial of Reminder 2 (trial 12) in Linear Model)
				
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
		
		
		
		
		drop if trial < 12
		
		meglm dv i.stimulus i.hierarchicaltraining ///
				i.stimulus#i.hierarchicaltraining || id:

		matrix ab=e(b)
		matrix list ab

		*change brackets to match where "var(e.dv)" is (where "dv" is the name of the dv). This should also match the number of columns.
		global Vab = ab[1,13]

		*change "id" to be whatever the variable is for participants' ids
		*change brackets so that it reflects the column number for "var(_cons~)" (i.e., [1,X]
		constraint 1 _b[/var(_cons[id])]= ab[1,12]
		
		*This is the same as the meglm above except this one contains ", coeflegend" at the end
		meglm dv i.stimulus i.hierarchicaltraining ///
				i.stimulus#i.hierarchicaltraining || id:, coeflegend

		*Remove the main effect or interaction for which you want to know the effect size
		*If this worked correctly, you will see "constrained" in the "id var(_cons)" and "Std. Err." cell
		meglm dv i.stimulus i.hierarchicaltraining || id:, constraints(1)

		matrix a = e(b)
		matrix li a

		*change brackets to match where "var(e.dv)" is (where "dv" is the name of the dv). This should also match the number of columns.
		global Va = a[1,8]
			
		*Empty model - remove all predictors
		*If this worked correctly, you will see "constrained" in the "id var(_cons)" and "Std. Err." cell
		meglm dv || id:, constraints(1)

		matrix null=e(b)
		matrix list null
		*change brackets to match where "var(e.dv)" is (where "dv" is the name of the dv). This should also match the number of columns.
		global Vnull = null[1,3]

		global R2ab = ($Vnull - $Vab)/$Vnull
		global R2a = ($Vnull - $Va)/$Vnull

		display "Proportion explained full model = $R2ab"
		display "Proportion explained reduced model = $R2a"

		global f2b = ($R2ab - $R2a)/(1-$R2ab)
		display "Effect size f2 = $f2b"
			
		global fb = sqrt(($R2ab - $R2a)/(1-$R2ab))
		display "Effect size f = $fb"

		
*** Extinction		
		
		import delimited "`c(pwd)'/OS_Transfer_Exp_Ext_Alpha_V0.csv", clear
		
		* Define label for transfertraining
		label define transfer_lbl 1 "Generalization" 2 "Ambiguous" 3 "Specificity"
		label values transfertraining transfer_lbl

		* Define label for hierarchicaltraining
		label define hierarchical_lbl 0 "PR Control" 1 "True OS"
		label values hierarchicaltraining hierarchical_lbl	
	
	* ext_alpha
		
		meglm ext_alpha i.transfertraining i.hierarchicaltraining ///
				i.transfertraining#i.hierarchicaltraining || id:

		matrix ab=e(b)
		matrix list ab

		*change brackets to match where "var(e.ext_alpha)" is (where "ext_alpha" is the name of the ext_alpha). This should also match the number of columns.
		global Vab = ab[1,14]

		*change "id" to be whatever the variable is for participants' ids
		*change brackets so that it reflects the column number for "var(_cons~)" (i.e., [1,X]
		constraint 1 _b[/var(_cons[id])]= ab[1,13]
		
		*This is the same as the meglm above except this one contains ", coeflegend" at the end
		meglm ext_alpha i.transfertraining i.hierarchicaltraining ///
				i.transfertraining#i.hierarchicaltraining || id:, coeflegend

		*Remove the main effect or interaction for which you want to know the effect size
		*If this worked correctly, you will see "constrained" in the "id var(_cons)" and "Std. Err." cell
		meglm ext_alpha i.transfertraining i.hierarchicaltraining || id:, constraints(1)

		matrix a = e(b)
		matrix li a

		*change brackets to match where "var(e.ext_alpha)" is (where "ext_alpha" is the name of the ext_alpha). This should also match the number of columns.
		global Va = a[1,8]
			
		*Empty model - remove all predictors
		*If this worked correctly, you will see "constrained" in the "id var(_cons)" and "Std. Err." cell
		meglm ext_alpha || id:, constraints(1)

		matrix null=e(b)
		matrix list null
		*change brackets to match where "var(e.ext_alpha)" is (where "ext_alpha" is the name of the ext_alpha). This should also match the number of columns.
		global Vnull = null[1,3]

		global R2ab = ($Vnull - $Vab)/$Vnull
		global R2a = ($Vnull - $Va)/$Vnull

		display "Proportion explained full model = $R2ab"
		display "Proportion explained reduced model = $R2a"

		global f2b = ($R2ab - $R2a)/(1-$R2ab)
		display "Effect size f2 = $f2b"
			
		global fb = sqrt(($R2ab - $R2a)/(1-$R2ab))
		display "Effect size f = $fb"
	
	*ext_alpha controlling for ext_intercept
	
		meglm ext_alpha c.ext_intercept i.transfertraining i.hierarchicaltraining ///
				i.transfertraining#i.hierarchicaltraining || id:

		matrix ab=e(b)
		matrix list ab

		*change brackets to match where "var(e.ext_alpha)" is (where "ext_alpha" is the name of the ext_alpha). This should also match the number of columns.
		global Vab = ab[1,15]

		*change "id" to be whatever the variable is for participants' ids
		*change brackets so that it reflects the column number for "var(_cons~)" (i.e., [1,X]
		constraint 1 _b[/var(_cons[id])]= ab[1,14]
		
		*This is the same as the meglm above except this one contains ", coeflegend" at the end
		meglm ext_alpha c.ext_intercept i.transfertraining i.hierarchicaltraining ///
				i.transfertraining#i.hierarchicaltraining || id:, coeflegend

		*Remove the main effect or interaction for which you want to know the effect size
		*If this worked correctly, you will see "constrained" in the "id var(_cons)" and "Std. Err." cell
		meglm ext_alpha c.ext_intercept i.transfertraining i.hierarchicaltraining || id:, constraints(1)

		matrix a = e(b)
		matrix li a

		*change brackets to match where "var(e.ext_alpha)" is (where "ext_alpha" is the name of the ext_alpha). This should also match the number of columns.
		global Va = a[1,9]
			
		*Empty model - remove all predictors
		*If this worked correctly, you will see "constrained" in the "id var(_cons)" and "Std. Err." cell
		meglm ext_alpha || id:, constraints(1)

		matrix null=e(b)
		matrix list null
		*change brackets to match where "var(e.ext_alpha)" is (where "ext_alpha" is the name of the ext_alpha). This should also match the number of columns.
		global Vnull = null[1,3]

		global R2ab = ($Vnull - $Vab)/$Vnull
		global R2a = ($Vnull - $Va)/$Vnull

		display "Proportion explained full model = $R2ab"
		display "Proportion explained reduced model = $R2a"

		global f2b = ($R2ab - $R2a)/(1-$R2ab)
		display "Effect size f2 = $f2b"
			
		global fb = sqrt(($R2ab - $R2a)/(1-$R2ab))
		display "Effect size f = $fb"
		
*** Occasion Setting Was Learned in the True Occasion Setting Condition, and CS Partial Reinforcement Was Learned in the Partial Reinforcement Control Condition

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
	
	* Declarative Test – Cognitive Learning: 50% CS Partial Reinforcement, Modulation, and Configuration.
	
		meglm dv i.stimulus i.transfertraining i.hierarchicaltraining ///
				i.stimulus#i.transfertraining i.stimulus#i.hierarchicaltraining i.transfertraining#i.hierarchicaltraining ///
				i.stimulus#i.transfertraining#i.hierarchicaltraining || id:

		matrix ab=e(b)
		matrix list ab

		*change brackets to match where "var(e.dv)" is (where "dv" is the name of the dv). This should also match the number of columns.
		global Vab = ab[1,50]

		*change "id" to be whatever the variable is for participants' ids
		*change brackets so that it reflects the column number for "var(_cons~)" (i.e., [1,X]
		constraint 1 _b[/var(_cons[id])]= ab[1,49]
		
		*This is the same as the meglm above except this one contains ", coeflegend" at the end
		meglm dv i.stimulus i.transfertraining i.hierarchicaltraining ///
				i.stimulus#i.transfertraining i.stimulus#i.hierarchicaltraining i.transfertraining#i.hierarchicaltraining ///
				i.stimulus#i.transfertraining#i.hierarchicaltraining || id:, coeflegend

		*Remove the main effect or interaction for which you want to know the effect size
		*If this worked correctly, you will see "constrained" in the "id var(_cons)" and "Std. Err." cell
		meglm dv i.stimulus i.transfertraining i.hierarchicaltraining ///
				i.stimulus#i.transfertraining i.stimulus#i.hierarchicaltraining i.transfertraining#i.hierarchicaltraining || id:, constraints(1)

		matrix a = e(b)
		matrix li a

		*change brackets to match where "var(e.dv)" is (where "dv" is the name of the dv). This should also match the number of columns.
		global Va = a[1,32]
			
		*Empty model - remove all predictors
		*If this worked correctly, you will see "constrained" in the "id var(_cons)" and "Std. Err." cell
		meglm dv || id:, constraints(1)

		matrix null=e(b)
		matrix list null
		*change brackets to match where "var(e.dv)" is (where "dv" is the name of the dv). This should also match the number of columns.
		global Vnull = null[1,3]

		global R2ab = ($Vnull - $Vab)/$Vnull
		global R2a = ($Vnull - $Va)/$Vnull

		display "Proportion explained full model = $R2ab"
		display "Proportion explained reduced model = $R2a"

		global f2b = ($R2ab - $R2a)/(1-$R2ab)
		display "Effect size f2 = $f2b"
			
		global fb = sqrt(($R2ab - $R2a)/(1-$R2ab))
		display "Effect size f = $fb"

	* Trial-By-Trial Test – Partial Reinforcement Extinction Effect (PREE).
	
		import delimited "`c(pwd)'/OS_Transfer_Exp_Ext_Alpha_V0.csv", clear
		
		* Define label for transfertraining
		label define transfer_lbl 1 "Generalization" 2 "Ambiguous" 3 "Specificity"
		label values transfertraining transfer_lbl

		* Define label for hierarchicaltraining
		label define hierarchical_lbl 0 "PR Control" 1 "True OS"
		label values hierarchicaltraining hierarchical_lbl	
	
	* ext_alpha
		
		meglm ext_alpha i.hierarchicaltraining || id:

		matrix ab=e(b)
		matrix list ab

		*change brackets to match where "var(e.ext_alpha)" is (where "ext_alpha" is the name of the ext_alpha). This should also match the number of columns.
		global Vab = ab[1,5]

		*change "id" to be whatever the variable is for participants' ids
		*change brackets so that it reflects the column number for "var(_cons~)" (i.e., [1,X]
		constraint 1 _b[/var(_cons[id])]= ab[1,4]
		
		*This is the same as the meglm above except this one contains ", coeflegend" at the end
		meglm ext_alpha i.hierarchicaltraining || id:, coeflegend

		*Remove the main effect or interaction for which you want to know the effect size
		*If this worked correctly, you will see "constrained" in the "id var(_cons)" and "Std. Err." cell
		meglm ext_alpha || id:, constraints(1)

		matrix a = e(b)
		matrix li a

		*change brackets to match where "var(e.ext_alpha)" is (where "ext_alpha" is the name of the ext_alpha). This should also match the number of columns.
		global Va = a[1,3]
			
		*Empty model - remove all predictors
		*If this worked correctly, you will see "constrained" in the "id var(_cons)" and "Std. Err." cell
		meglm ext_alpha || id:, constraints(1)

		matrix null=e(b)
		matrix list null
		*change brackets to match where "var(e.ext_alpha)" is (where "ext_alpha" is the name of the ext_alpha). This should also match the number of columns.
		global Vnull = null[1,3]

		global R2ab = ($Vnull - $Vab)/$Vnull
		global R2a = ($Vnull - $Va)/$Vnull

		display "Proportion explained full model = $R2ab"
		display "Proportion explained reduced model = $R2a"

		global f2b = ($R2ab - $R2a)/(1-$R2ab)
		display "Effect size f2 = $f2b"
			
		global fb = sqrt(($R2ab - $R2a)/(1-$R2ab))
		display "Effect size f = $fb"

*** Occasion Setting Can Produce Varying Degrees of Transfer as Expected, Ranging from Full to Low Transfer

	* Within True Occasion Setting – Comparing Transfer Training Conditions.

		* Difference score - Trained minus Transfer
		
			import delimited "`c(pwd)'/OS_Transfer_Exp_Test1_TrainedTransferDiff.csv", clear
			drop if hierarchicaltraining == 0
			
			* Define label for transfertraining
			label define transfer_lbl 1 "Generalization" 2 "Ambiguous" 3 "Specificity"
			label values transfertraining transfer_lbl

			* Define label for hierarchicaltraining
			label define hierarchical_lbl 0 "PR Control" 1 "True OS"
			label values hierarchicaltraining hierarchical_lbl
			
			
			
			
			meglm dv i.transfertraining
 
			matrix ab=e(b)
			matrix list ab

			*change brackets to match where "var(e.dv)" is (where "dv" is the name of the dv). This should also match the number of columns.
			global Vab = ab[1,5]

			*change "id" to be whatever the variable is for participants' ids
			*change brackets so that it reflects the column number for "var(_cons~)" (i.e., [1,X]
			constraint 1 _b[/var(_cons[id])]= ab[1,4]
			
			*This is the same as the meglm above except this one contains ", coeflegend" at the end
			meglm dv i.transfertraining, coeflegend

			*Remove the main effect or interaction for which you want to know the effect size
			*If this worked correctly, you will see "constrained" in the "id var(_cons)" and "Std. Err." cell
			meglm dv, constraints(1)

			matrix a = e(b)
			matrix li a

			*change brackets to match where "var(e.dv)" is (where "dv" is the name of the dv). This should also match the number of columns.
			global Va = a[1,2]
				
			*Empty model - remove all predictors
			*If this worked correctly, you will see "constrained" in the "id var(_cons)" and "Std. Err." cell
			meglm dv || id:, constraints(1)

			matrix null=e(b)
			matrix list null
			*change brackets to match where "var(e.dv)" is (where "dv" is the name of the dv). This should also match the number of columns.
			global Vnull = null[1,3]

			global R2ab = ($Vnull - $Vab)/$Vnull
			global R2a = ($Vnull - $Va)/$Vnull

			display "Proportion explained full model = $R2ab"
			display "Proportion explained reduced model = $R2a"

			global f2b = ($R2ab - $R2a)/(1-$R2ab)
			display "Effect size f2 = $f2b"
				
			global fb = sqrt(($R2ab - $R2a)/(1-$R2ab))
			display "Effect size f = $fb"

	* Within Each Transfer Training Condition – Comparing Across True Occasion Setting and Partial Reinforcement Control
	
		* Difference score - Trained minus Transfer
		
			import delimited "`c(pwd)'/OS_Transfer_Exp_Test1_TrainedTransferDiff.csv", clear
			
			* Define label for transfertraining
			label define transfer_lbl 1 "Generalization" 2 "Ambiguous" 3 "Specificity"
			label values transfertraining transfer_lbl

			* Define label for hierarchicaltraining
			label define hierarchical_lbl 0 "PR Control" 1 "True OS"
			label values hierarchicaltraining hierarchical_lbl
			
			meglm dv i.transfertraining i.hierarchicaltraining ///
				i.transfertraining#i.hierarchicaltraining

			matrix ab=e(b)
			matrix list ab

			*change brackets to match where "var(e.dv)" is (where "dv" is the name of the dv). This should also match the number of columns.
			global Vab = ab[1,13]

			*change "id" to be whatever the variable is for participants' ids
			*change brackets so that it reflects the column number for "var(_cons~)" (i.e., [1,X]
			constraint 1 _b[/var(_cons[id])]= ab[1,12]
			
			*This is the same as the meglm above except this one contains ", coeflegend" at the end
			meglm dv i.transfertraining i.hierarchicaltraining ///
					i.transfertraining#i.hierarchicaltraining, coeflegend

			*Remove the main effect or interaction for which you want to know the effect size
			*If this worked correctly, you will see "constrained" in the "id var(_cons)" and "Std. Err." cell
			meglm dv i.transfertraining i.hierarchicaltraining, constraints(1)

			matrix a = e(b)
			matrix li a

			*change brackets to match where "var(e.dv)" is (where "dv" is the name of the dv). This should also match the number of columns.
			global Va = a[1,7]
				
			*Empty model - remove all predictors
			*If this worked correctly, you will see "constrained" in the "id var(_cons)" and "Std. Err." cell
			meglm dv || id:, constraints(1)

			matrix null=e(b)
			matrix list null
			*change brackets to match where "var(e.dv)" is (where "dv" is the name of the dv). This should also match the number of columns.
			global Vnull = null[1,3]

			global R2ab = ($Vnull - $Vab)/$Vnull
			global R2a = ($Vnull - $Va)/$Vnull

			display "Proportion explained full model = $R2ab"
			display "Proportion explained reduced model = $R2a"

			global f2b = ($R2ab - $R2a)/(1-$R2ab)
			display "Effect size f2 = $f2b"
				
			global fb = sqrt(($R2ab - $R2a)/(1-$R2ab))
			display "Effect size f = $fb"
			
*** Occasion Setting Can Produce Varying Degrees of Beliefs Regarding Generalization and Specificity of Transferability of Occasion Setters to CSs

	*Retaining General and Specific Values
	
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
			
			
		
		
		meglm dv i.transfertraining i.stimulus ///
				i.transfertraining#i.stimulus || id:

		matrix ab=e(b)
		matrix list ab

		*change brackets to match where "var(e.ext_alpha)" is (where "ext_alpha" is the name of the ext_alpha). This should also match the number of columns.
		global Vab = ab[1,14]

		*change "id" to be whatever the variable is for participants' ids
		*change brackets so that it reflects the column number for "var(_cons~)" (i.e., [1,X]
		constraint 1 _b[/var(_cons[id])]= ab[1,13]
		
		*This is the same as the meglm above except this one contains ", coeflegend" at the end
		meglm dv i.transfertraining i.stimulus ///
				i.transfertraining#i.stimulus || id:, coeflegend

		*Remove the main effect or interaction for which you want to know the effect size
		*If this worked correctly, you will see "constrained" in the "id var(_cons)" and "Std. Err." cell
		meglm dv i.transfertraining i.stimulus || id:, constraints(1)

		matrix a = e(b)
		matrix li a

		*change brackets to match where "var(e.ext_alpha)" is (where "ext_alpha" is the name of the ext_alpha). This should also match the number of columns.
		global Va = a[1,8]
			
		*Empty model - remove all predictors
		*If this worked correctly, you will see "constrained" in the "id var(_cons)" and "Std. Err." cell
		meglm dv || id:, constraints(1)

		matrix null=e(b)
		matrix list null
		*change brackets to match where "var(e.ext_alpha)" is (where "ext_alpha" is the name of the ext_alpha). This should also match the number of columns.
		global Vnull = null[1,3]

		global R2ab = ($Vnull - $Vab)/$Vnull
		global R2a = ($Vnull - $Va)/$Vnull

		display "Proportion explained full model = $R2ab"
		display "Proportion explained reduced model = $R2a"

		global f2b = ($R2ab - $R2a)/(1-$R2ab)
		display "Effect size f2 = $f2b"
			
		global fb = sqrt(($R2ab - $R2a)/(1-$R2ab))
		display "Effect size f = $fb"	
			
	* Difference score - General minus Specific		
			
		import delimited "`c(pwd)'/OS_Transfer_Latent_Learning_GenMinusSpec.csv", clear
		drop if hierarchicaltraining == 0
		
		* Define label for transfertraining
		label define transfer_lbl 1 "Generalization" 2 "Ambiguous" 3 "Specificity"
		label values transfertraining transfer_lbl

		* Define label for hierarchicaltraining
		label define hierarchical_lbl 0 "PR Control" 1 "True OS"
		label values hierarchicaltraining hierarchical_lbl	
			
			
			
			
		meglm dv i.transfertraining
 
		matrix ab=e(b)
		matrix list ab

		*change brackets to match where "var(e.dv)" is (where "dv" is the name of the dv). This should also match the number of columns.
		global Vab = ab[1,5]

		*change "id" to be whatever the variable is for participants' ids
		*change brackets so that it reflects the column number for "var(_cons~)" (i.e., [1,X]
		constraint 1 _b[/var(_cons[id])]= ab[1,4]
		
		*This is the same as the meglm above except this one contains ", coeflegend" at the end
		meglm dv i.transfertraining, coeflegend

		*Remove the main effect or interaction for which you want to know the effect size
		*If this worked correctly, you will see "constrained" in the "id var(_cons)" and "Std. Err." cell
		meglm dv, constraints(1)

		matrix a = e(b)
		matrix li a

		*change brackets to match where "var(e.dv)" is (where "dv" is the name of the dv). This should also match the number of columns.
		global Va = a[1,2]
			
		*Empty model - remove all predictors
		*If this worked correctly, you will see "constrained" in the "id var(_cons)" and "Std. Err." cell
		meglm dv || id:, constraints(1)

		matrix null=e(b)
		matrix list null
		*change brackets to match where "var(e.dv)" is (where "dv" is the name of the dv). This should also match the number of columns.
		global Vnull = null[1,3]

		global R2ab = ($Vnull - $Vab)/$Vnull
		global R2a = ($Vnull - $Va)/$Vnull

		display "Proportion explained full model = $R2ab"
		display "Proportion explained reduced model = $R2a"

		global f2b = ($R2ab - $R2a)/(1-$R2ab)
		display "Effect size f2 = $f2b"
			
		global fb = sqrt(($R2ab - $R2a)/(1-$R2ab))
		display "Effect size f = $fb"	
			
*** The Specific Occasion Setter / CS Combination and Possibly the CS that Underwent the Extinction Procedure Were Extinguished			
			
	* Main Results
	
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
		
		meglm dv i.transfertraining i.stimulus ///
					i.transfertraining#i.stimulus || id:

		matrix ab=e(b)
		matrix list ab

		*change brackets to match where "var(e.ext_alpha)" is (where "ext_alpha" is the name of the ext_alpha). This should also match the number of columns.
		global Vab = ab[1,22]

		*change "id" to be whatever the variable is for participants' ids
		*change brackets so that it reflects the column number for "var(_cons~)" (i.e., [1,X]
		constraint 1 _b[/var(_cons[id])]= ab[1,21]
		
		*This is the same as the meglm above except this one contains ", coeflegend" at the end
		meglm dv i.transfertraining i.stimulus ///
				i.transfertraining#i.stimulus || id:, coeflegend

		*Remove the main effect or interaction for which you want to know the effect size
		*If this worked correctly, you will see "constrained" in the "id var(_cons)" and "Std. Err." cell
		meglm dv i.transfertraining i.stimulus || id:, constraints(1)

		matrix a = e(b)
		matrix li a

		*change brackets to match where "var(e.ext_alpha)" is (where "ext_alpha" is the name of the ext_alpha). This should also match the number of columns.
		global Va = a[1,10]
			
		*Empty model - remove all predictors
		*If this worked correctly, you will see "constrained" in the "id var(_cons)" and "Std. Err." cell
		meglm dv || id:, constraints(1)

		matrix null=e(b)
		matrix list null
		*change brackets to match where "var(e.ext_alpha)" is (where "ext_alpha" is the name of the ext_alpha). This should also match the number of columns.
		global Vnull = null[1,3]

		global R2ab = ($Vnull - $Vab)/$Vnull
		global R2a = ($Vnull - $Va)/$Vnull

		display "Proportion explained full model = $R2ab"
		display "Proportion explained reduced model = $R2a"

		global f2b = ($R2ab - $R2a)/(1-$R2ab)
		display "Effect size f2 = $f2b"
			
		global fb = sqrt(($R2ab - $R2a)/(1-$R2ab))
		display "Effect size f = $fb"
	
	* OS/CS Combination 
	
		* Generalization Training vs Ambiguous Training
	
			import delimited "`c(pwd)'/OS_Transfer_Exp_Test1_2_Diff.csv", clear
					
				* Define label for transfertraining
				label define transfer_lbl 1 "Generalization" 2 "Ambiguous" 3 "Specificity"
				label values transfertraining transfer_lbl

				* Define label for hierarchicaltraining
				label define hierarchical_lbl 0 "PR Control" 1 "True OS"
				label values hierarchicaltraining hierarchical_lbl
				
				drop if hierarchicaltraining == 0
				drop if transfertraining == 3
				
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
			
			meglm dv i.transfertraining i.stimulus ///
						i.transfertraining#i.stimulus || id:

			matrix ab=e(b)
			matrix list ab

			*change brackets to match where "var(e.ext_alpha)" is (where "ext_alpha" is the name of the ext_alpha). This should also match the number of columns.
			global Vab = ab[1,17]

			*change "id" to be whatever the variable is for participants' ids
			*change brackets so that it reflects the column number for "var(_cons~)" (i.e., [1,X]
			constraint 1 _b[/var(_cons[id])]= ab[1,16]
			
			*This is the same as the meglm above except this one contains ", coeflegend" at the end
			meglm dv i.transfertraining i.stimulus ///
					i.transfertraining#i.stimulus || id:, coeflegend

			*Remove the main effect or interaction for which you want to know the effect size
			*If this worked correctly, you will see "constrained" in the "id var(_cons)" and "Std. Err." cell
			meglm dv i.transfertraining i.stimulus || id:, constraints(1)

			matrix a = e(b)
			matrix li a

			*change brackets to match where "var(e.ext_alpha)" is (where "ext_alpha" is the name of the ext_alpha). This should also match the number of columns.
			global Va = a[1,9]
				
			*Empty model - remove all predictors
			*If this worked correctly, you will see "constrained" in the "id var(_cons)" and "Std. Err." cell
			meglm dv || id:, constraints(1)

			matrix null=e(b)
			matrix list null
			*change brackets to match where "var(e.ext_alpha)" is (where "ext_alpha" is the name of the ext_alpha). This should also match the number of columns.
			global Vnull = null[1,3]

			global R2ab = ($Vnull - $Vab)/$Vnull
			global R2a = ($Vnull - $Va)/$Vnull

			display "Proportion explained full model = $R2ab"
			display "Proportion explained reduced model = $R2a"

			global f2b = ($R2ab - $R2a)/(1-$R2ab)
			display "Effect size f2 = $f2b"
				
			global fb = sqrt(($R2ab - $R2a)/(1-$R2ab))
			display "Effect size f = $fb"
			
		* Generalization Training vs Specificity Training
	
			import delimited "`c(pwd)'/OS_Transfer_Exp_Test1_2_Diff.csv", clear
					
				* Define label for transfertraining
				label define transfer_lbl 1 "Generalization" 2 "Ambiguous" 3 "Specificity"
				label values transfertraining transfer_lbl

				* Define label for hierarchicaltraining
				label define hierarchical_lbl 0 "PR Control" 1 "True OS"
				label values hierarchicaltraining hierarchical_lbl
				
				drop if hierarchicaltraining == 0
				drop if transfertraining == 2
				
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
			
			meglm dv i.transfertraining i.stimulus ///
						i.transfertraining#i.stimulus || id:

			matrix ab=e(b)
			matrix list ab

			*change brackets to match where "var(e.ext_alpha)" is (where "ext_alpha" is the name of the ext_alpha). This should also match the number of columns.
			global Vab = ab[1,17]

			*change "id" to be whatever the variable is for participants' ids
			*change brackets so that it reflects the column number for "var(_cons~)" (i.e., [1,X]
			constraint 1 _b[/var(_cons[id])]= ab[1,16]
			
			*This is the same as the meglm above except this one contains ", coeflegend" at the end
			meglm dv i.transfertraining i.stimulus ///
					i.transfertraining#i.stimulus || id:, coeflegend

			*Remove the main effect or interaction for which you want to know the effect size
			*If this worked correctly, you will see "constrained" in the "id var(_cons)" and "Std. Err." cell
			meglm dv i.transfertraining i.stimulus || id:, constraints(1)

			matrix a = e(b)
			matrix li a

			*change brackets to match where "var(e.ext_alpha)" is (where "ext_alpha" is the name of the ext_alpha). This should also match the number of columns.
			global Va = a[1,9]
				
			*Empty model - remove all predictors
			*If this worked correctly, you will see "constrained" in the "id var(_cons)" and "Std. Err." cell
			meglm dv || id:, constraints(1)

			matrix null=e(b)
			matrix list null
			*change brackets to match where "var(e.ext_alpha)" is (where "ext_alpha" is the name of the ext_alpha). This should also match the number of columns.
			global Vnull = null[1,3]

			global R2ab = ($Vnull - $Vab)/$Vnull
			global R2a = ($Vnull - $Va)/$Vnull

			display "Proportion explained full model = $R2ab"
			display "Proportion explained reduced model = $R2a"

			global f2b = ($R2ab - $R2a)/(1-$R2ab)
			display "Effect size f2 = $f2b"
				
			global fb = sqrt(($R2ab - $R2a)/(1-$R2ab))
			display "Effect size f = $fb"	
			
		* Ambiguous Training vs Specificity Training
	
			import delimited "`c(pwd)'/OS_Transfer_Exp_Test1_2_Diff.csv", clear
					
				* Define label for transfertraining
				label define transfer_lbl 1 "Generalization" 2 "Ambiguous" 3 "Specificity"
				label values transfertraining transfer_lbl

				* Define label for hierarchicaltraining
				label define hierarchical_lbl 0 "PR Control" 1 "True OS"
				label values hierarchicaltraining hierarchical_lbl
				
				drop if hierarchicaltraining == 0
				drop if transfertraining == 1
				
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
			
			meglm dv i.transfertraining i.stimulus ///
						i.transfertraining#i.stimulus || id:

			matrix ab=e(b)
			matrix list ab

			*change brackets to match where "var(e.ext_alpha)" is (where "ext_alpha" is the name of the ext_alpha). This should also match the number of columns.
			global Vab = ab[1,17]

			*change "id" to be whatever the variable is for participants' ids
			*change brackets so that it reflects the column number for "var(_cons~)" (i.e., [1,X]
			constraint 1 _b[/var(_cons[id])]= ab[1,16]
			
			*This is the same as the meglm above except this one contains ", coeflegend" at the end
			meglm dv i.transfertraining i.stimulus ///
					i.transfertraining#i.stimulus || id:, coeflegend

			*Remove the main effect or interaction for which you want to know the effect size
			*If this worked correctly, you will see "constrained" in the "id var(_cons)" and "Std. Err." cell
			meglm dv i.transfertraining i.stimulus || id:, constraints(1)

			matrix a = e(b)
			matrix li a

			*change brackets to match where "var(e.ext_alpha)" is (where "ext_alpha" is the name of the ext_alpha). This should also match the number of columns.
			global Va = a[1,9]
				
			*Empty model - remove all predictors
			*If this worked correctly, you will see "constrained" in the "id var(_cons)" and "Std. Err." cell
			meglm dv || id:, constraints(1)

			matrix null=e(b)
			matrix list null
			*change brackets to match where "var(e.ext_alpha)" is (where "ext_alpha" is the name of the ext_alpha). This should also match the number of columns.
			global Vnull = null[1,3]

			global R2ab = ($Vnull - $Vab)/$Vnull
			global R2a = ($Vnull - $Va)/$Vnull

			display "Proportion explained full model = $R2ab"
			display "Proportion explained reduced model = $R2a"

			global f2b = ($R2ab - $R2a)/(1-$R2ab)
			display "Effect size f2 = $f2b"
				
			global fb = sqrt(($R2ab - $R2a)/(1-$R2ab))
			display "Effect size f = $fb"	
			
