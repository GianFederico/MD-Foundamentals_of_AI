/*


  This program is designed to answer questions about relationships within

  a given family tree. The program will tell you who the mother, father,

  sister, brother, aunt, uncle, grandmother, grandfather, ancestor, and descendent

  of someone is.  

  The standard form is predicate(someone, relation). 

  where the relation will be the mother or father or so on.



*/

husband(X):-married(X,_), male(X).
wife(X):-married(_,X), female(X).





male(gianfe).

male(antonio).

male(giovanni).

male(giacomo).

male(pino).

male(giuseppe).




female(giorgia).

female(elena).

female(rosa).

female(carmela).

female(manuela).

female(mariella).



/*  parent (parent, child).  SWITCH*/

parent(antonio, gianfe).

parent(antonio, giorgia).

parent(elena, gianfe).

parent(elena, giorgia).

parent(giovanni, antonio).

parent(giovanni, pino).

parent(giacomo, elena).

parent(giacomo, manuela).

parent(rosa, elena).

parent(rosa, manuela).

parent(carmela, antonio).

parent(carmela, pino).



/* married (A,B)  - A(male) is married to B(female) */

married(antonio, elena).

married(giovanni, carmela).

married(giacomo, rosa).

married(giuseppe, manuela).

married(pino, mariella).





/* rules */

/* Dad is the father of Child if he is male and is the child's parent */

father(Child, Dad) :- male(Dad), parent(Child, Dad).





/* Mom is the mother of Child if she is female and the child's parent*/

mother(Child, Mom) :- female(Mom), parent(Child, Mom).





/* Brother is the brother of Sibling if he is male and has the same parents as the sibling*/

brother(Sibling, Bro) :- male(Bro), father(Sibling, Father), father(Bro, Father), Bro \= Sibling,

                            mother(Sibling, Mother), mother(Bro, Mother).





/* Sister is the sister of Sibling if she is female and has the same parents as the sibling*/

sister(Sibling, Sis) :- female(Sis), father(Sibling, Father), father(Sis, Father), Sis \= Sibling,

                             mother(Sibling, Mother), mother(Sis, Mother).





/* Auntie is the aunt of someone if she is female and a sister of the someone's parent or

                        she is female and married to the someone's uncle

*/

aunt(Kid, Auntie) :- female(Auntie), parent(Kid, Parent), sister(Parent, Auntie).

aunt(Kid, Auntie) :- female(Auntie), parent(Kid, Person), brother(Person, Brother), married(Auntie, Brother).





/* Unclebuck is the uncle of Kid if he is male and a brother of the kid's parent or

                            he is male and married to the kid's aunt

*/

uncle(Kid, UncleBuck) :- male(UncleBuck), parent(Kid, Parent), brother(Parent, UncleBuck).

uncle(Kid, UncleBuck) :- male(UncleBuck), parent(Kid, Person), sister(Person, Sister), married(UncleBuck, Sister).





/* Grandmother is the grandmother of Grandchild if she is female and the parent of the grandchild's parent */

grandmother(Grandchild, Grandmother) :- female(Grandmother), parent(Grandchild, Parent), parent(Parent, Grandmother).





/* Grandfather is the grandfather of GrandChild if he is male and the parent of the child's parent */

grandfather(Grandchild, Grandfather) :- male(Grandfather), parent(Grandchild, Parent), parent(Parent, Grandfather).






/* Person is an ancestor of Descendent

      You are the ancestor if you are the parent of the person or

                        you are the parent of the person's parent and so forth

*/

ancestor(Person, Ancestor) :- parent(Person, Ancestor).

ancestor(Person, Ancestor) :- parent(Person, Parent), ancestor(Parent, Ancestor).





/* Person is a descendent of Ancestor
      You are the descendent if you are the child of the person or
                        your parent is the child of the person and so forth

*/

descendent(Person, Descendent) :- parent(Descendent, Person).
descendent(Person, Descendent) :- parent(Descendent, Someone), descendent(Person, Someone).