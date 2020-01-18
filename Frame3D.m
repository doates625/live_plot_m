classdef Frame3D < LivePlots.Plot
    %FRAME3D Class for plotting 3D coordinate frames
    %   Author: Dan Oates (WPI Class of 2020)
    
    properties (SetAccess = protected)
        plot_x;     % X-axis unit vector plot [LivePlots.Vector3D]
        plot_y;     % Y-axis unit vector plot [LivePlots.Vector3D]
        plot_z;     % Z-axis unit vector plot [LivePlots.Vector3D]
        unit_len;   % Unit vector lengths
    end
    
    methods (Access = public)
        function obj = Frame3D(unit_len, axes_)
            %obj = FRAME3D(unit_len, axes_)
            %   Construct 3D frame plot
            %   
            %   Inputs:
            %   - unit_len = Unit vector lengths [double, default = 1.0]
            %   - axes_ = Axes handle [Axes, default = gca]
            
            % Default args
            if nargin < 2, axes_ = gca; end
            if nargin < 1, unit_len = 1.0; end
            
            % Construction
            obj@LivePlots.Plot(axes_);
            obj.plot_x = LivePlots.Vector3D(axes_);
            obj.plot_y = LivePlots.Vector3D(axes_);
            obj.plot_z = LivePlots.Vector3D(axes_);
            obj.unit_len = unit_len;
        end
        
        function update(obj, rotation, origin)
            %UPDATE(obj, rotation, origin)
            %   Update frame plot
            %   
            %   Inputs:
            %   - rotation = Rotation matrix [double, size = [3, 3]]
            %   - origin = Global frame origin [[x; y; z], default = 0]
            
            % Default args
            if nargin < 3, origin = zeros(3, 1); end
            
            % Extract unit vectors
            x_hat = obj.unit_len * rotation(:, 1);
            y_hat = obj.unit_len * rotation(:, 2);
            z_hat = obj.unit_len * rotation(:, 3);
            
            % Update vector plots
            obj.plot_x.update(x_hat, origin);
            obj.plot_y.update(y_hat, origin);
            obj.plot_z.update(z_hat, origin);
        end
    end
end