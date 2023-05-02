classdef Distribucion_cargas_lineales < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                        matlab.ui.Figure
        PosicionYinicialcargaspositivasEditField  matlab.ui.control.NumericEditField
        PosicionYinicialcargaspositivasEditFieldLabel  matlab.ui.control.Label
        EditField2                      matlab.ui.control.NumericEditField
        EditField2Label                 matlab.ui.control.Label
        PosicionXinicialcargaspositivasEditField  matlab.ui.control.NumericEditField
        PosicionXinicialcargaspositivasEditFieldLabel  matlab.ui.control.Label
        DistanciaentrecargasEditField   matlab.ui.control.NumericEditField
        DistanciaentrecargasEditFieldLabel  matlab.ui.control.Label
        CargaGlobuloRojoEditField       matlab.ui.control.NumericEditField
        CargaGlobuloRojoEditFieldLabel  matlab.ui.control.Label
        CargaLineasparalelaasEditField  matlab.ui.control.NumericEditField
        CargaLineasparalelaasEditFieldLabel  matlab.ui.control.Label
        Cambiar_eje                     matlab.ui.control.Switch
        CambiardeEjeLabel               matlab.ui.control.Label
        Simular                         matlab.ui.control.Button
        Graficar                        matlab.ui.control.UIAxes
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Value changed function: CargaLineasparalelaasEditField
        function CargaLineasparalelaasEditFieldValueChanged(app, event)
            carga = app.CargaLineasparalelaasEditField.Value;
            
        end

        % Value changed function: CargaGlobuloRojoEditField
        function CargaGlobuloRojoEditFieldValueChanged(app, event)
            carga_globulo= app.CargaGlobuloRojoEditField.Value;
        end

        % Value changed function: DistanciaentrecargasEditField
        function DistanciaentrecargasEditFieldValueChanged(app, event)
            distancia_entre_cargas = app.DistanciaentrecargasEditField.Value;
            
        end

        % Value changed function: Cambiar_eje
        function Cambiar_ejeValueChanged(app, event)
            eje = app.Cambiar_eje.Value;
            
        end

        % Value changed function: PosicionYinicialcargaspositivasEditField
        function PosicionYinicialcargaspositivasEditFieldValueChanged(app, event)
            posYicargaP = app.PosicionYinicialcargaspositivasEditField.Value;
            
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 909 553];
            app.UIFigure.Name = 'MATLAB App';

            % Create Graficar
            app.Graficar = uiaxes(app.UIFigure);
            title(app.Graficar, 'Distribucion cargas lineales')
            xlabel(app.Graficar, 'Campo electrico eje X')
            ylabel(app.Graficar, 'Campo electrico eje Y')
            app.Graficar.DataAspectRatio = [100 100 100];
            app.Graficar.XTick = [];
            app.Graficar.YTick = [];
            app.Graficar.Box = 'on';
            app.Graficar.Position = [312 10 560 526];

            % Create Simular
            app.Simular = uibutton(app.UIFigure, 'push');
            app.Simular.Position = [91 56 100 23];
            app.Simular.Text = 'Simular';

            % Create CambiardeEjeLabel
            app.CambiardeEjeLabel = uilabel(app.UIFigure);
            app.CambiardeEjeLabel.HorizontalAlignment = 'center';
            app.CambiardeEjeLabel.Position = [96 107 88 22];
            app.CambiardeEjeLabel.Text = 'Cambiar de Eje';

            % Create Cambiar_eje
            app.Cambiar_eje = uiswitch(app.UIFigure, 'slider');
            app.Cambiar_eje.Items = {'Eje Y', 'Eje X'};
            app.Cambiar_eje.ValueChangedFcn = createCallbackFcn(app, @Cambiar_ejeValueChanged, true);
            app.Cambiar_eje.Position = [117 144 45 20];
            app.Cambiar_eje.Value = 'Eje Y';

            % Create CargaLineasparalelaasEditFieldLabel
            app.CargaLineasparalelaasEditFieldLabel = uilabel(app.UIFigure);
            app.CargaLineasparalelaasEditFieldLabel.HorizontalAlignment = 'right';
            app.CargaLineasparalelaasEditFieldLabel.Position = [74 449 133 22];
            app.CargaLineasparalelaasEditFieldLabel.Text = 'Carga Lineas paralelaas';

            % Create CargaLineasparalelaasEditField
            app.CargaLineasparalelaasEditField = uieditfield(app.UIFigure, 'numeric');
            app.CargaLineasparalelaasEditField.ValueChangedFcn = createCallbackFcn(app, @CargaLineasparalelaasEditFieldValueChanged, true);
            app.CargaLineasparalelaasEditField.Position = [214 449 67 22];

            % Create CargaGlobuloRojoEditFieldLabel
            app.CargaGlobuloRojoEditFieldLabel = uilabel(app.UIFigure);
            app.CargaGlobuloRojoEditFieldLabel.HorizontalAlignment = 'right';
            app.CargaGlobuloRojoEditFieldLabel.Position = [74 417 110 22];
            app.CargaGlobuloRojoEditFieldLabel.Text = 'Carga Globulo Rojo';

            % Create CargaGlobuloRojoEditField
            app.CargaGlobuloRojoEditField = uieditfield(app.UIFigure, 'numeric');
            app.CargaGlobuloRojoEditField.ValueChangedFcn = createCallbackFcn(app, @CargaGlobuloRojoEditFieldValueChanged, true);
            app.CargaGlobuloRojoEditField.Position = [214 417 69 22];

            % Create DistanciaentrecargasEditFieldLabel
            app.DistanciaentrecargasEditFieldLabel = uilabel(app.UIFigure);
            app.DistanciaentrecargasEditFieldLabel.HorizontalAlignment = 'right';
            app.DistanciaentrecargasEditFieldLabel.Position = [74 388 124 22];
            app.DistanciaentrecargasEditFieldLabel.Text = 'Distancia entre cargas';

            % Create DistanciaentrecargasEditField
            app.DistanciaentrecargasEditField = uieditfield(app.UIFigure, 'numeric');
            app.DistanciaentrecargasEditField.ValueChangedFcn = createCallbackFcn(app, @DistanciaentrecargasEditFieldValueChanged, true);
            app.DistanciaentrecargasEditField.Position = [214 388 67 22];

            % Create PosicionXinicialcargaspositivasEditFieldLabel
            app.PosicionXinicialcargaspositivasEditFieldLabel = uilabel(app.UIFigure);
            app.PosicionXinicialcargaspositivasEditFieldLabel.HorizontalAlignment = 'right';
            app.PosicionXinicialcargaspositivasEditFieldLabel.Position = [53 351 185 22];
            app.PosicionXinicialcargaspositivasEditFieldLabel.Text = 'Posicion X inicial cargas positivas';

            % Create PosicionXinicialcargaspositivasEditField
            app.PosicionXinicialcargaspositivasEditField = uieditfield(app.UIFigure, 'numeric');
            app.PosicionXinicialcargaspositivasEditField.Position = [250 351 55 22];

            % Create EditField2Label
            app.EditField2Label = uilabel(app.UIFigure);
            app.EditField2Label.HorizontalAlignment = 'right';
            app.EditField2Label.Position = [52 262 62 22];
            app.EditField2Label.Text = 'Edit Field2';

            % Create EditField2
            app.EditField2 = uieditfield(app.UIFigure, 'numeric');
            app.EditField2.Position = [129 262 100 22];

            % Create PosicionYinicialcargaspositivasEditFieldLabel
            app.PosicionYinicialcargaspositivasEditFieldLabel = uilabel(app.UIFigure);
            app.PosicionYinicialcargaspositivasEditFieldLabel.HorizontalAlignment = 'right';
            app.PosicionYinicialcargaspositivasEditFieldLabel.Position = [53 319 185 22];
            app.PosicionYinicialcargaspositivasEditFieldLabel.Text = 'Posicion Y inicial cargas positivas';

            % Create PosicionYinicialcargaspositivasEditField
            app.PosicionYinicialcargaspositivasEditField = uieditfield(app.UIFigure, 'numeric');
            app.PosicionYinicialcargaspositivasEditField.ValueChangedFcn = createCallbackFcn(app, @PosicionYinicialcargaspositivasEditFieldValueChanged, true);
            app.PosicionYinicialcargaspositivasEditField.Position = [250 319 55 22];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Distribucion_cargas_lineales

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end