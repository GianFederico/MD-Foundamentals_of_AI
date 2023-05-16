:- module(diagnosis_module, [diagnosis/1, questioncode/2]).

:- use_module(user_interaction_module).

%:- prolog_flag(unknown, _, fail).

/* Top-level diagnosis rules */

diagnosis('Fuse blown') :- power_problem, askif(lights_out).
diagnosis('Fuse blown') :- power_problem, askif(hear(pop)).
diagnosis('Break in cord') :- power_problem, askif(cord_frayed).
diagnosis('Short in cord') :- diagnosis('Fuse blown'), askif(cord_frayed).
diagnosis('Device not turned on') :- power_problem, klutz_user, askif(has('an on-off switch or control')), askifnot(device_on).
diagnosis('Cord not in socket properly') :- power_problem, klutz_user, askif(just_plugged), askifnot(in_socket).
diagnosis('Foreign matter caught on heating element') :- heating_element, \+(power_problem), askif(smell_smoke).
diagnosis('Appliance wet (dry it out and try again)') :- power_problem, klutz_user, askif(liquids).
diagnosis('Controls adjusted improperly') :- klutz_user, askif(has('knobs or switches')).
diagnosis('Kick it, then try it again') :- mechanical_problem.
diagnosis('Throw it out and get a new one').

/* Definitions of intermediate predicates */
power_problem :- askif(device_dead).
power_problem :- askif(has('knobs or switches')), askifnot(knobs_do_something).
power_problem :- askif(smell_smoke), \+(heating_element).
klutz_user :- askifnot(handyperson).
klutz_user :- askifnot(familiar_appliance).
mechanical_problem :- askif(hear('weird noise')), askif(has('moving parts')).
heating_element :- askif(heats).
heating_element :- askif(powerful).

/* Question decoding */
questioncode(device_dead, 'Does the device refuse to do anything').
questioncode(knobs_do_something, 'Does changing the switch positions or tuning the knobs change anything').
questioncode(lights_out, 'Do all the lights in the house seem to be off').
questioncode(cord_frayed, 'Does the outer covering of the cord appear to be coming apart').
questioncode(handyperson, 'Are you good at fixing things').
questioncode(familiar_appliance, 'Are you familiar with how this appliance works').
questioncode(device_on, 'Is the ON/OFF switch set to ON').
questioncode(just_plugged, 'Did you just plug the appliance in').
questioncode(in_socket, 'Is the cord firmly plugged into the socket').
questioncode(smell_smoke, 'Do you smell smoke').
questioncode(liquids, 'Have any liquids spilled on the appliance just now').
questioncode(heats, 'Does the appliance heat things').
questioncode(powerful, 'Does the appliance require a lot of power').
questioncode(has(X), X) :- write('Does the appliance have ').
questioncode(hear(X), X) :- write('Did you hear a ').
