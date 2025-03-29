function [ theta, y1model] = LeastSquare(y1, t,u1,u2) %y1=Vc y2=Vr
    syms s;
    poly = (s+120)^2;
    lambda = sym2poly(poly);

    G1 = tf([-1, 0], lambda);
    G2 = tf([0, -1], lambda);
    G3 = tf([1, 0], lambda);
    G4 = tf([0, 1],lambda);
    G5 = tf([1, 0], lambda);
    G6 = tf([0, 1],lambda);

    % Υπολογισμός των εκτιμημένων τιμών των φάσματος
    phi1 = lsim(G1, y1, t);
    phi2 = lsim(G2, y1, t);
    phi3 = lsim(G3, u1(t), t);
    phi4 = lsim(G4, u1(t), t);
    phi5 = lsim(G5, u2*ones(size(t)), t);
    phi6 = lsim(G6, u2*ones(size(t)), t);

    % Αντιστοίχιση των δεδομένων εισόδου και εξόδου στον πίνακα PHI
    PHI = [phi1, phi2, phi3 ,phi4 ,phi5 ,phi6];

    % Υπολογισμός του θήτα θέσης
    theta = y1' * PHI / (PHI' * PHI);

   y1model = PHI * theta';
   
end