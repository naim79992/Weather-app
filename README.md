#include <GL/glut.h> 
#include <iostream> 
 
// Define clipping window boundaries 
const int X_MIN = 50; 
const int Y_MIN = 50; 
const int X_MAX = 300; 
const int Y_MAX = 300; 
 
// Region codes 
const int INSIDE = 0;  // 0000 
const int LEFT = 1;    // 0001 
const int RIGHT = 2;   // 0010 
const int BOTTOM = 4;  // 0100 
const int TOP = 8;     // 1000 
 
int computeCode(int x, int y) { 
    int code = INSIDE; 
    if (x < X_MIN) code |= LEFT; 
    if (x > X_MAX) code |= RIGHT; 
    if (y < Y_MIN) code |= BOTTOM; 
    if (y > Y_MAX) code |= TOP; 
    return code; 
} 
 
void display() { 
    glClear(GL_COLOR_BUFFER_BIT); 
 
    // Draw clipping rectangle 
    glColor3f(1.0, 0.0, 0.0); // Red 
    glBegin(GL_LINE_LOOP); 
    glVertex2i(X_MIN, Y_MIN); 
    glVertex2i(X_MAX, Y_MIN); 
    glVertex2i(X_MAX, Y_MAX); 
    glVertex2i(X_MIN, Y_MAX); 
    glEnd(); 
 
    // Lines to be clipped 
    int lines[][4] = { 
        {20, 30, 300, 400}, 
        {60, 20, 400, 200}, 
        {70, 260, 120, 50} 
    }; 
 
    glColor3f(0.0, 1.0, 0.0); // Green 
 
    for (int i = 0; i < 3; i++) { 
        int x1 = lines[i][0], y1 = lines[i][1]; 
        int x2 = lines[i][2], y2 = lines[i][3]; 
 
        int code1 = computeCode(x1, y1); 
        int code2 = computeCode(x2, y2); 
        bool accept = false; 
 
        while (true) { 
            if ((code1 == 0) && (code2 == 0)) { 
                accept = true; 
                break; 
            } 
            else if (code1 & code2) { 
                break; 
            } 
            else { 
                int code_out; 
                int x, y; 
 
                code_out = code1 ? code1 : code2; 
 
                if (code_out & TOP) { 
                    x = x1 + (x2 - x1) * (Y_MAX - y1) / (y2 - y1); 
                    y = Y_MAX; 
                } 
                else if (code_out & BOTTOM) { 
                    x = x1 + (x2 - x1) * (Y_MIN - y1) / (y2 - y1); 
                    y = Y_MIN; 
                } 
                else if (code_out & RIGHT) { 
                    y = y1 + (y2 - y1) * (X_MAX - x1) / (x2 - x1); 
                    x = X_MAX; 
                } 
                else if (code_out & LEFT) { 
                    y = y1 + (y2 - y1) * (X_MIN - x1) / (x2 - x1); 
                    x = X_MIN; 
                } 
 
                if (code_out == code1) { 
                    x1 = x; 
                    y1 = y; 
                    code1 = computeCode(x1, y1); 
                } 
                else { 
                    x2 = x; 
                    y2 = y; 
                    code2 = computeCode(x2, y2); 
                } 
            } 
        } 
 
        if (accept) { 
            glBegin(GL_LINES); 
            glVertex2i(x1, y1); 
            glVertex2i(x2, y2); 
            glEnd(); 
        } 
    } 
 
    glFlush(); 
} 
 
int main(int argc, char** argv) { 
    glutInit(&argc, argv); 
    glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB); 
    glutInitWindowSize(500, 500); 
    glutInitWindowPosition(100, 100); 
    glutCreateWindow("212-15-14721"); 
    gluOrtho2D(0, 500, 0, 500); 
    glutDisplayFunc(display); 
    glClearColor(1.0, 1.0, 1.0, 1.0); 
    glutMainLoop(); 
    return 0; 
}
beside comment
