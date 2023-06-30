circle_x += circle_vx;
circle_y += circle_vy;
circle_vy += 0.05;
circle_vy *= 0.999;

if(circle_vx > 0.5) {circle_vx = 0.5;}
if(circle_vx < -0.5) {circle_vx = -0.5;}

if(circle_x < 0) {circle_x = 0; circle_vx *= -(1 - 0.1 + random(0.3));}
if(circle_y < 0) {circle_y = 0; circle_vy *= -(1 - random(0.2));}
if(circle_x > floor_cw) {circle_x = floor_cw; circle_vx  *= -(1 - 0.1 + random(0.3));}
if(circle_y > floor_ch) {circle_y = floor_ch; circle_vy *= -1;}



if !is_undefined(surf_vtex) {

}