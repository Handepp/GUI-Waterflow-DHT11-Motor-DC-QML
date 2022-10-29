import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Button {
    id: button
    leftPadding: 4
    rightPadding: 4
    topPadding: 12
    bottomPadding: 12
    implicitWidth: 300/mainscreen.width * mainscreen.width//60
    implicitHeight: 450/implicitWidth * implicitWidth//90 
    icon.name: "placeholder"
    icon.width: 220/mainscreen.width* mainscreen.width //44
    icon.height:  220/mainscreen.height * mainscreen.height//44

 
    display: Button.TextUnderIcon
    background : Rectangle{
        border.color : "#00FFFF"
        border.width : 2
        radius : 2
        color : "#010911"
    }
    
}