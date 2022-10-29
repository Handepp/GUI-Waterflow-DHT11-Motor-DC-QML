import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Button {
    id: button
    leftPadding: 4
    rightPadding: 4
    topPadding: 12
    bottomPadding: 12
    implicitWidth: 0.17142 * root1.width//60
    implicitHeight: 1.5 * implicitWidth//90 
    icon.name: "placeholder"
    icon.width:  0.12571* root1.width //44
    icon.height:  0.07333* root1.height//44

    display: Button.TextUnderIcon
    background : Rectangle{
        border.color : "#00FFFF"
        border.width : 2
        radius : 2
        color:"#010911"
    }
    
}