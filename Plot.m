classdef (Abstract) Plot < handle
    %PLOT Superclass for live plots
    %   Author: Dan Oates (WPI Class of 2020)
    
    properties (SetAccess = protected)
        axes_;  % Axes handle [Axes]
    end
    
    methods (Access = public)
        function obj = Plot(axes_)
            %PLOT Construct live plot
            %   obj = PLOT(axes) Provide axes handle
            %   obj = PLOT() Use gca as axes handle
            if nargin < 1
                obj.axes_ = gca;
            else
                obj.axes_ = axes_;
            end
        end
    end
    methods (Access = public, Abstract)
        update(obj, varargin)
        %UPDATE(obj, varargin) Update plot with new data
    end
end