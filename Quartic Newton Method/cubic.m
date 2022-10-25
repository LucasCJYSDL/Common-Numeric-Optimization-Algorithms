function x = cubic(a, b, c, d)
a = vpa(a, 22); b = vpa(b, 22); c = vpa(c, 22); d = vpa(d, 22);
A = b*b - 3*a*c;   if abs(A) < 1e-21;    A = 0;  end
B = b*c - 9*a*d;   if abs(B) < 1e-21;    B = 0;  end
C = c*c - 3*b*d;   if abs(C) < 1e-21;    C = 0;  end  
DET = B*B - 4*A*C; if abs(DET) < 1e-21;  DET = 0;  end  
if (A == 0) && (B == 0)
    x1 = -c/b;      x2 = x1 ;    x3 = x1;
end
if DET > 0
    Y1 = A*b + 1.5*a*(-B + sqrt(DET));
    Y2 = A*b + 1.5*a*(-B - sqrt(DET));
    y1 = nthroot(Y1,3);  y2 = nthroot(Y2,3);
    x1 = (-b-y1-y2)/(3*a);
    vec1 = (-b + 0.5*(y1 + y2))/(3*a);  
    vec2 = 0.5*sqrt(3)*(y1 - y2)/(3*a);
    x2 = complex(double(vec1), double(vec2));
    x3 = complex(double(vec1), double(-vec2));
    clear Y1 Y2 y1 y2 vec1 vec2;
end
if DET == 0 && (A ~= 0) && (B ~= 0)
    K = (b*c-9*a*d)/(b*b - 3*a*c); K = round(K,21);
    x1 = -b/a + K;   x2 = -0.5*K;   x3 = x2;
end
if DET < 0
    sqA = sqrt(A);
    T = (A*b - 1.5*a*B)/(A*sqA);
    theta = acos(T);
    csth  = cos(theta/3);
    sn3th = sqrt(3)*sin(theta/3);
    x1 = (-b - 2*sqA*csth)/(3*a);
    x2 = (-b + sqA*(csth + sn3th))/(3*a);
    x3 = (-b + sqA*(csth - sn3th))/(3*a);
    clear sqA T theta csth sn3th;
end
x = [x1;  x2;  x3];

end
