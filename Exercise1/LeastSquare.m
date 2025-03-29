% Συνάρτηση LeastSquare
function [m, b, k, theta, ymodel] = LeastSquare(y, u, t)
    syms s;
    poly = s^2 + 3*s + 2;
    lambda = sym2poly(poly);

    G1 = tf([-1, 0], lambda);
    G2 = tf([0, -1], lambda);
    G3 = tf([0, 1], lambda);

    % Υπολογισμός των εκτιμημένων τιμών των φάσματος
    phi1 = lsim(G1, y(:, 1), t);
    phi2 = lsim(G2, y(:, 1), t);
    phi3 = lsim(G3, u(t), t);

    % Αντιστοίχιση των δεδομένων εισόδου και εξόδου στον πίνακα PHI
    PHI = [phi1, phi2, phi3];

    % Υπολογισμός του θήτα θέσης
    theta = y' * PHI / (PHI' * PHI);

    % Υπολογισμός των παραμέτρων
    m = 1 / theta(3);
    b = (2 + theta(1)) * m;
    k = (1 + theta(2)) * m;

    % Υπολογισμός της εκτιμημένης εξόδου
    ymodel = PHI * theta';
end