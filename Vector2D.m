classdef Vector2D < LivePlots.Plot
    %VECTOR2D Class for plotting 2D vectors
    %   Author: Dan Oates (WPI Class of 2020)
    
    properties (SetAccess = protected)
        plot_;  % Plot handle [Line]
    end
    
    methods (Access = public)
        function obj = Vector2D(axes_)
            %obj = VECTOR2D(axes_)
            %   Construct 2D vector plot
            %   
            %   Inputs:
            %   - axes_ = Axes handle [Axes, default = gca]
            if nargin < 1, axes_ = gca; end
            obj@LivePlots.Plot(axes_);
            obj.plot_ = plot(0, 0, 'Parent', axes_);
        end
        
        function update(obj, vector, origin)
            %UPDATE(obj, vector, origin)
            %   Update vector plot
            %   
            %   Inputs:
            %   - vector = 2D vector [x; y]
            %   - origin = Vector origin [[x; y], default = [0; 0]]
            if nargin < 3, origin =  [0; 0]; end
            endpt = origin + vector;
            obj.plot_.XData = [origin(1), endpt(1)];
            obj.plot_.YData = [origin(2), endpt(2)];
        end
    end
end