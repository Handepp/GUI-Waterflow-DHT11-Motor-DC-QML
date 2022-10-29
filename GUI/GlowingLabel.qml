import QtQuick 2.12
import QtQuick.Controls 2.12

// This container and the transform on the Label are
// necessary to get precise bounding rect of the text for layouting reasons,
// since some of the labels' font sizes can get quite large.
Item {
    id: root
    implicitHeight: labelTextMetrics.tightBoundingRect.height
    implicitWidth: label.implicitWidth

    property alias text: label.text
    property alias font: label.font
    property alias horizontalAlignment: label.horizontalAlignment
    property alias verticalAlignment: label.verticalAlignment
    property bool glowEnabled: true
    property color glowColor: colorGlow
    property color color: colorBright

    Label {
        id: label
        anchors.baseline: root.baseline
        color: root.color

        layer.enabled: root.glowEnabled
        layer.effect: CustomGlow {
            color: glowColor
        }

        TextMetrics {
            id: labelTextMetrics
            text: label.text
            font: label.font
        }

        transform: Translate {
            y: -labelTextMetrics.tightBoundingRect.y
        }
    }
}