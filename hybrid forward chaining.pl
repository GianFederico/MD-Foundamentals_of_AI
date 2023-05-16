% initial symptoms
symptom(fever).
symptom(cough).
symptom(runny_nose).
symptom(sore_throat).
symptom(body_ache).

% rules to diagnose the medical conditions
dummy :- not(symptom(flu)),
        symptom(fever), symptom(cough), symptom(body_ache),
        asserta(diagnosis(flu)).
dummy :- not(symptom(cold)),
        symptom(runny_nose), symptom(sore_throat), symptom(body_ache),
        asserta(diagnosis(cold)).
dummy :- not(symptom(covid)),
        symptom(fever), symptom(cough), symptom(body_ache), symptom(nausea), 
        asserta(diagnosis(covid)).

% main loop (entrypoint), checks every rules and also new knowledge
main_loop :-
    repeat,
    (   dummy, 
        fail;   
        check_new_knowledge,
        !   ).

% check for new knowledge
check_new_knowledge :-
    (   clause(diagnosis(X), true),
        retract(diagnosis(X)),
        write('Patient diagnosed with: '), write(X), nl,
        fail;   
        true    ).



