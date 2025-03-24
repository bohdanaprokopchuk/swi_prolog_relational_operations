% Операція об'єднання множин
% Вбудоване об'єднання множин з виведенням результату
union_builtin(Set1, Set2, Name, Result) :- 
    append(Set1, Set2, Temp),
    sort(Temp, Result),
    format("Об'єднання множин (~w): ~w\n", [Name, Result]).

% Ручне об'єднання множин без вбудованих предикатів
union([], L, _, L).
union([H|T], L, Name, R) :-
    member(H, L), union(T, L, Name, R).
union([H|T], L, Name, [H|R]) :-
    \+ member(H, L), union(T, L, Name, R).


% Операція перетину множин
% Вбудоване перетин множин з виведенням результату
intersection_builtin(Set1, Set2, Name, Result) :-
    findall(X, (member(X, Set1), member(X, Set2)), Temp),
    sort(Temp, Result),
    format("Перетин множин (~w): ~w\n", [Name, Result]).

% Ручне перетин множин без вбудованих предикатів
intersection([], _, _, []).
intersection([H|T], L, Name, [H|R]) :-
    member(H, L), intersection(T, L, Name, R).
intersection([_|T], L, Name, R) :-
    intersection(T, L, Name, R).


% Операція різниці множин
% Вбудоване визначення різниці множин
difference_builtin(Set1, Set2, Name, Result) :-
    findall(X, (member(X, Set1), \+ member(X, Set2)), Result),
    format("Різниця множин (~w): ~w\n", [Name, Result]).

% Ручне визначення різниці множин без вбудованих предикатів
difference([], _, _, []).
difference([H|T], L, Name, R) :-
    member(H, L), difference(T, L, Name, R).
difference([H|T], L, Name, [H|R]) :-
    \+ member(H, L), difference(T, L, Name, R).


% Операція декартового добутку множин
% Вбудоване обчислення декартового добутку множин
cartesian_product_builtin(Set1, Set2, Name, Result) :-
    findall([X,Y], (member(X, Set1), member(Y, Set2)), Result),
    format("Декартів добуток (~w): ~w\n", [Name, Result]).

% Ручне визначення декартового добутку множин
cartesian_product([], _, _, []).
cartesian_product([H|T], L, Name, R) :-
    pair(H, L, P),
    cartesian_product(T, L, Name, R1),
    append(P, R1, R).

pair(_, [], []).
pair(X, [Y|T], [[X,Y]|R]) :-
    pair(X, T, R).


% Операція ділення множин
% Вбудоване ділення множин з виведенням результату
division_builtin(A, B, Name, R) :-
    findall(X, (
        member([X,_], A),
        forall(member(Y, B), member([X,Y], A))
    ), R1),
    sort(R1, R),  % Видаляємо дублікати
    format("Ділення множин (~w): ~w\n", [Name, R]).

% Ручне визначення реляційного ділення множин
% Універсальний квантор для ділення (не вбудований)
all_r_for_all_b(S, R, A) :-
    \+ (member(B, S), \+ member((A, B), R)).

% Виконання операції ділення
division(S, R, A) :-
    member(A, [a,b,c]),  % Для прикладу - можливі значення A
    all_r_for_all_b(S, R, A).

% Приклад реляції R
r1([(a, 1), (a, 2), (b, 1), (c, 1), (c, 2)]).

% Приклад множини S
s1([1, 2]).

% Запит для ділення
run_division :-
    r1(R), s1(S),
    division(S, R, A),
    write(A), nl, fail.
run_division.
