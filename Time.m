classdef Time < LivePlots.Plot
    %TIME Class for live time plots
    %   
    %   Dependencies:
    %   - Timing.Timer
    %   
    %   Author: Dan Oates (WPI Class of 2020)
    
    properties (SetAccess = protected)
        plot_;      % Plot handle [Line]
        time_dur;   % Plot time duration [s]
    end
    
    properties (Access = protected)
        first_plot; % First plot flag [logical]
        timer;      % Timer [Timing.Timer]
    end
    
    methods
        function obj = Time(time_dur, axes_)
            %obj = TIME(time_dur, axes_)
            %   Construct live time plot
            %   
            %   Inputs:
            %   - time_dur = Plot time length [sec, default = 5.0]
            %   - axes_ = Axes handle [Axes, default = gca]
            
            % Default args
            if nargin < 2, axes_ = gca; end
            if nargin < 1, time_dur = 5.0; end
            
            % Superconstructor
            obj@LivePlots.Plot(axes_)
            
            % Properties
            obj.plot_ = plot(0, 0, 'Parent', axes_);
            obj.time_dur = time_dur;
            obj.first_plot = true;
            obj.timer = timing.Timer();
        end
        
        function update(obj, x, t)
            %UPDATE(obj, x, t)
            %   Update plot with new time-stamped value
            %   
            %   Inputs:
            %   - x = New value to plot [double]
            %   - t = Timestamp [s]
            %   
            %   If no timestamp is given, the internal timer is used.
            
            if obj.first_plot
                % First plot
                if nargin < 3
                    obj.timer.tic();
                    t = 0;
                end
                obj.plot_.XData = t;
                obj.plot_.YData = x;
                obj.axes_.XLim = [0, obj.time_dur];
                obj.first_plot = false;
            else
                % Following plots
                if nargin < 3
                    t = obj.timer.toc();
                end
                keep_is = find(obj.plot_.XData > t - obj.time_dur);
                obj.plot_.XData = [obj.plot_.XData(keep_is), t];
                obj.plot_.YData = [obj.plot_.YData(keep_is), x];
                t_max = max(obj.time_dur, t(end));
                t_min = max(0, t_max - obj.time_dur);
                obj.axes_.XLim = [t_min, t_max];
            end
        end
    end
end