classdef Frame2D < live_plot.Plot
    %FRAME2D Class for plotting 2D coordinate frames
    %   Author: Dan Oates (WPI Class of 2020)
    
    properties (SetAccess = protected)
        plot_x;     % X-axis unit vector plot [live_plot.Vector2D]
        plot_y;     % Y-axis unit vector plot [live_plot.Vector2D]
        unit_len;   % Unit vector lengths
    end
    
    methods (Access = public)
        function obj = Frame2D(unit_len, axes_)
            %obj = FRAME2D(unit_len, axes_)
            %   Construct 2D frame plot
            %   
            %   Inputs:
            %   - unit_len = Unit vector lengths [double, default = 1.0]
            %   - axes_ = Axes handle [Axes, default = gca]
            
            % Imports
            import('live_plot.Vector2D');
            
            % Default args
            if nargin < 2, axes_ = gca; end
            if nargin < 1, unit_len = 1.0; end
            
            % Construction
            obj@live_plot.Plot(axes_);
            obj.plot_x = Vector2D(axes_);
            obj.plot_y = Vector2D(axes_);
            obj.unit_len = unit_len;
        end
        
        function update(obj, angle, origin)
            %UPDATE(obj, angle, origin)
            %   Update frame plot
            %   
            %   Inputs:
            %   - angle = Global z-axis rotation [rad]
            %   - origin = Global frame origin [[x; y], default = 0]
            
            % Default args
            if nargin < 3, origin =  zeros(2, 1); end
            
            % Extract unit vectors
            cos_a = obj.unit_len * cos(angle);
            sin_a = obj.unit_len * sin(angle);
            x_hat = [+cos_a; +sin_a];
            y_hat = [-sin_a; +cos_a];
            
            % Update vector plots
            obj.plot_x.update(x_hat, origin);
            obj.plot_y.update(y_hat, origin);
        end
    end
end