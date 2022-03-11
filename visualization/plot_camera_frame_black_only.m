function [h] = plot_camera_frame_black_only(R_gc, p_gc, camScale, color)
%
% plot_camera_frame_only: draw a camera in the current figure
%
% draw_camera( location, color )
%
% input
%   location: 3D position and orientation (via quaternion)


% define the camera body and frame
depth = -0.45;
camBody = zeros(3,4);
camBody(:,1) = camScale * [0.32;-0.24;depth];
camBody(:,2) = camScale * [-0.32;-0.24;depth];
camBody(:,3) = camScale * [-0.32;0.24;depth];
camBody(:,4) = camScale * [0.32;0.24;depth];


% rotate the camera body and frame from {C} to {G}
camBody = R_gc * camBody;


% translate the camera body and frame
camBody = camBody + [p_gc(1:3) p_gc(1:3) p_gc(1:3) p_gc(1:3)];


% draw the camera body
line([camBody(1,1) p_gc(1)],[camBody(2,1) p_gc(2)],[camBody(3,1) p_gc(3)],'Color', color, 'LineWidth', 1.5);
line([camBody(1,2) p_gc(1)],[camBody(2,2) p_gc(2)],[camBody(3,2) p_gc(3)],'Color', color, 'LineWidth', 1.5);
line([camBody(1,3) p_gc(1)],[camBody(2,3) p_gc(2)],[camBody(3,3) p_gc(3)],'Color', color, 'LineWidth', 1.5);
line([camBody(1,4) p_gc(1)],[camBody(2,4) p_gc(2)],[camBody(3,4) p_gc(3)],'Color', color, 'LineWidth', 1.5);

line([camBody(1,1) camBody(1,2)],[camBody(2,1) camBody(2,2)],[camBody(3,1) camBody(3,2)],'Color', color, 'LineWidth', 1.5);
line([camBody(1,2) camBody(1,3)],[camBody(2,2) camBody(2,3)],[camBody(3,2) camBody(3,3)],'Color', color, 'LineWidth', 1.5);
line([camBody(1,3) camBody(1,4)],[camBody(2,3) camBody(2,4)],[camBody(3,3) camBody(3,4)],'Color', color, 'LineWidth', 1.5);
h = line([camBody(1,4) camBody(1,1)],[camBody(2,4) camBody(2,1)],[camBody(3,4) camBody(3,1)],'Color', color, 'LineWidth', 1.5);


end

