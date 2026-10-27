data {
    // It is imperative that the trials are ordered with each ID

    // Total number of trials
    int<lower=0> N;

    // Number of stimuli
    int<lower=0>n_stimuli;

    // Number of entries in each level of the hierarchy
    int n_participants;

    // Index to keep track of which subject we're using
    array[N] int participant_index;

    // Trial number of a given participant
    array[N] int trialseq;

    // Result of trial
    array[N] real DV;

    // Did the US occur?
    array[N] int<lower=0, upper=1> US;

}

// transformed data {
//     // Transform DV to be on a scale from 0 to 1 (currently 1 to 5)
//     array[N] real DV;
//     for (i in 1:N) {
//         DV[i] = (DV[i] - 1) / 4.0;
//     }
// }


parameters {
    // Hyperparameters level 0
    real<lower=0, upper=1> alpha_group;
    array[n_stimuli] real<lower=0, upper=1> V0_group;
    real<lower=0> tau_alpha;
    real<lower=0> tau_V0;

    // Parameters
    vector<lower=0, upper=1>[n_participants] alpha_indiv;
    array[n_participants, n_stimuli] real<lower=0, upper=1> V0_indiv;
    real<lower=0> sigma;
}

transformed parameters {
  // Compute theoretical learning
  array[N, n_stimuli] real V;

  // V[i] is interpreted to be describing what has been learned
  // going *in* to trial i. This is really important. This is why for trialseq[i] = 1, it is
  // set to zero, since there is no experience.

  // What you know going *in* to trial [i] =
  // What you KNEW going into trial [i - 1] (effectively, what you learned two trials ago) +
  // what you LEARNED from trial [i - 1] (effectively, what you learned one trial ago).

  for (i in 1:N) {
      for (j in 1:n_stimuli) {
          if (trialseq[i] == 1) {
              V[i, j] = V0_indiv[participant_index[i], j];
          }
          else {
              V[i, j] = V[i - 1, j] + alpha_indiv[participant_index[i]] * (US[i-1] - V[i-1, j]);
          }
      }
  }
}



model {
    // Hyperpriors
    // Tau is the degree to which hyperpriors affect individual priors; 0 = individual priors are pooled, 1 = individual priors are completely independent.
    alpha_group ~ beta(1, 1);
    for (j in 1:n_stimuli) {
        V0_group[j] ~ beta(1, 1);
    }
    tau_alpha ~ normal(0, 0.2);
    tau_V0 ~ normal(0, 0.2);

    // Priors
    alpha_indiv ~ beta(alpha_group / tau_alpha, (1-alpha_group) / tau_alpha);
    for (i in 1:n_participants) {
        for (j in 1:n_stimuli) {
            V0_indiv[i, j] ~ beta(V0_group[j] / tau_V0, (1 - V0_group[j]) / tau_V0);
        }
    }
    sigma ~ normal(0, 0.2);


    // Likelihood
    for (i in 1:N) {
        DV[i] ~ normal(sum(V[i]), sigma);
    }
}


generated quantities {
    array[N] real DV_ppc;
    array[N] real DV_log_like;

    for (i in 1:N) {
        DV_ppc[i] = normal_rng(sum(V[i]), sigma);
    }

    for (i in 1:N) {
        DV_log_like[i] = normal_lpdf(DV[i] | sum(V[i]), sigma);
    }
}
