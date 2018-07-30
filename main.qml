import QtQuick 2.9
import QtQuick.Window 2.2

Window {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Rectangle {
        id: rect
        width: root.width
        height: root.height
        color: "pink"

        visible: true
        layer.enabled: true
        layer.effect: ShaderEffect {
            id: effect
            width: background.width
            height: background.height
            property real time: 0
            UniformAnimator on time {
                from: 0.0
                to: 1.0
                duration: 0
                running: true
                loops: Animation.Infinite
            }

            vertexShader: "#version 410
                            uniform highp mat4 qt_Matrix;
                            in highp vec4 qt_Vertex;
                            in highp vec2 qt_MultiTexCoord0;
                            out highp vec2 coord;
                            void main() {
                                coord = qt_MultiTexCoord0;
                                gl_Position = qt_Matrix * qt_Vertex;
                            }
                            "
            fragmentShader: "#version 410
                            in highp vec2 coord;
                            uniform highp float time;
                            uniform sampler2D source;
                            uniform lowp float qt_Opacity;
                            out lowp vec4 outColor;
                            void main() {
                                lowp vec4 tex = texture(source, coord);
                                lowp float alpha;
                                if ( coord.x > time )
                                {
                                    outColor = vec4(1.0, 1.0, 1.0, 1.0);
                                }
                                else
                                {
                                    outColor = tex * qt_Opacity;
                                }

                            }"
        }
    }
}
