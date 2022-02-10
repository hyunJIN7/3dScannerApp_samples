function plot_line_normals_unit_sphere(imageCurForLine, cam, optsMWMS)

% detect lines and related line normals
[lines, ~, lineNormals] = extractLinesAndGreatcircle(imageCurForLine, cam, optsMWMS);
lineNormals = lineNormals.';


% plot normal vector of great circle from image lines
for k = 1:size(lineNormals,2)
    normal = lineNormals(:,k);
    plot3(normal(1),normal(2),normal(3),'o','MarkerSize',10,'LineWidth',2.0,'Color','k','MarkerFaceColor',[0.5,0.5,0.5]);
end


end

