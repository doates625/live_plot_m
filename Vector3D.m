classdef Vector3D < live_plot.Plot
    %VECTOR3D Class for plotting 3D vectors
    %   Author: Dan Oates (WPI Class of 2020)
    
    properties (SetAccess = protected)
        plot_;  % Plot handle [Line]
    end
    
    methods
        function obj = Vector3D(axes_)
            %obj = VECTOR3D(axes_)
            %   Construct 3D vector plot
            %   
            %   Inputs:
            %   - axes_ = Axes handle [Axes, default = gca]
            if nargin < 1, axes_ = gca; end
            obj@live_plot.Plot(axes_);
            obj.plot_ = plot3(0, 0, 0, 'Parent', axes_);
        end
        
        function update(obj, vector, origin)
            %UPDATE(obj, vector, origin)
            %   Update vector plot
            %   
            %   Inputs:
            %   - vector = 3D vector [x; y; z]
            %   - origin = Vector origin [[x; y; z], default = [0; 0; 0]]
            if nargin < 3, origin =  [0; 0; 0]; end
            endpt = origin + vector;
            obj.plot_.XData = [origin(1), endpt(1)];
            obj.plot_.YData = [origin(2), endpt(2)];
            obj.plot_.ZData = [origin(3), endpt(3)];
        end
    end
end