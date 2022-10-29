import QtQuick.Shapes 1.15
import SDK 1.0
import QtQuick.Layouts 1.1
import QtCharts 2.1
import QtQuick 2.15 //2.5
import QtQuick.Window 2.15 //2.15
import QtQuick.Controls 1.4 //1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Extras.Private 1.0
import QtGraphicalEffects 1.12
import QtQml 2.15


Rectangle {
	id : root
	visible: true
	width: 1380
	height: 768
	color: "#010911"
	
	property string suffix1: " L/min"
    property int minVal1: 0
    property int maxVal1: 15
    property real actVal1: 0

	property string suffix2: " L"
    property int minVal2: 0
    property real actVal2: 0

	property string suffix3: " °C"
    property int minVal3: 0
    property int maxVal3: 100
    property real actVal3: 0

	property string suffix4: " %RH"
    property int minVal4: 0
    property int maxVal4: 100
    property real actVal4: 0

	property string suffix5: " PWM"
    property int minVal5: 0
    property int maxVal5: 255
    property real actVal5: 0

	property string suffix6: " PWM"
    property int minVal6: 0
    property int maxVal6: 255
    property real actVal6: 0

	readonly property color colorGlow: "#1d6d64"
    readonly property color colorBright: "#ffffff"
 
    readonly property int fontSizeExtraSmall: Qt.application.font.pixelSize * 0.8
    readonly property int fontSizeMedium: Qt.application.font.pixelSize * 1.5
    readonly property int fontSizeLarge: Qt.application.font.pixelSize * 2
    readonly property int fontSizeExtraLarge: Qt.application.font.pixelSize * 5

    function flow_rate(text) {
    	root.actVal1 = text;
	}

    function total_liter(text) {
    	root.actVal2 = text;
	}

	function esp_status(text) {
		if(text == "ON"){
			statusIndicator.text = "ON"
		}
 		else{
			statusIndicator.text = "OFF"
		}
	}

	function temp_status(text) {
    	root.actVal3 = text;
	}

	function hum_status(text) {
    	root.actVal4 = text;
	}

    Rectangle {
		id: splashscreen
		width:1380
		height:768
		visible: true
		gradient : Gradient{
			GradientStop { position : 0 ; color : "#010911"}
			GradientStop { position : 5 ; color : "#00FFFF"}
		}
        z : 3

		ProgressBar {
			id:loading
			visible: true
			indeterminate: true
            value :timersplash.interval
            anchors.horizontalCenter : splashscreen.horizontalCenter
            anchors.bottom : splashscreen.bottom
            anchors.bottomMargin : 200
            style: ProgressBarStyle {
                    background: Rectangle {
                    radius: 2
                    color: "#00FFFF"
                    border.color: "gray"
                    border.width: 1
                    implicitWidth: 400
                    implicitHeight: 12
                }
            }
		}

        Image {
            id:splashimgunpad
            width: 150
            height: 130
            source: "logo-unpad1"
            anchors.bottom : splashscreen.bottom
            anchors.bottomMargin : 400
            anchors.left : splashscreen.left
            anchors.leftMargin : 370
        }

        Image {
            id:splashimgsyergie
            width: 150
            height: 60
            source: "syergielogofix"
            anchors.bottom : splashscreen.bottom
            anchors.bottomMargin : 280
            anchors.left : splashscreen.left
            anchors.leftMargin : 370
        }

        GlowingLabel {
			text: qsTr("Water Flow Sensor")
			font.family : "Lato"
			color: "white"
			font.pointSize : 30
            anchors.bottom : splashscreen.bottom
            anchors.bottomMargin : 460
            anchors.left : splashscreen.left
            anchors.leftMargin : 620
		}

        GlowingLabel {
			text: qsTr("Temperature & Humidity Sensor")
			font.family : "Lato"
			color: "white"
			font.pointSize : 30
            anchors.bottom : splashscreen.bottom
            anchors.bottomMargin : 360
            anchors.left : splashscreen.left
            anchors.leftMargin : 620
		}

        GlowingLabel {
			text: qsTr("DC Motor Control")
			font.family : "Lato"
			color: "white"
			font.pointSize : 30
            anchors.bottom : splashscreen.bottom
            anchors.bottomMargin : 260
            anchors.left : splashscreen.left
            anchors.leftMargin : 620
		}

        Rectangle{
            id:recline
            width:5
            height : 250
            color : "#00FFFF"
            anchors.verticalCenter : splashscreen.verticalCenter
            anchors.left : splashscreen.left
            anchors.leftMargin : 570
            radius : 5
        }
            
		Timer {
            id : timersplash
			interval: 7500
			repeat: false
			running: true
			triggeredOnStart: false
			onTriggered: {
				splashscreen.visible = false;
			}
		}
	}
	
	Rectangle {
		id: mainscreen
		width:1380
		height:768
		visible: true
		gradient : Gradient{
			GradientStop { position : 0 ; color : "#010911"}
			GradientStop { position : 5 ; color : "#00FFFF"}
		}
        z : 2

		GlowingLabel {
			text: qsTr("Pilih menu yang ingin ditampilkan")
			font.family : "Lato"
			color: "white"
			font.pointSize : 50
            anchors.top : parent.top
            anchors.topMargin : 100
            anchors.horizontalCenter:parent.horizontalCenter
		}

		/*
		GlowingLabel {
			text: qsTr("Menu dapat dipilih kembali pada bagian kiri atas pada \nhalaman selanjutnya")
			font.family : "Lato"
			color: "white"
			font.pointSize : 30
            anchors.top : parent.top
            anchors.topMargin : 200
            anchors.horizontalCenter:parent.horizontalCenter
		}
		*/


		Row{
			id: rowbuttonmain
            anchors.horizontalCenter : parent.horizontalCenter
			anchors.bottom :parent.bottom
			anchors.bottomMargin:75
            spacing: 50
			
			FeatureButtonMain {
				id: waterbuttonmain
				text: qsTr("Water")
				font.family : "Lato"
				font.pointSize : 45
				icon.name: "Watericon"
				icon.source : "water.png"
				Layout.fillHeight: true
				checked:true
			
				onClicked : {
					if (waterbuttonmain.text == "Water"  ) {
						root21.visible = true
						root22.visible = true
						waterimg.visible = true
						waterimgcolor.visible=true
						watertext.visible = true
						temperature.visible = false
						temperaturecolor.visible = false
						temptext.visible = false
						motorimg.visible = false
						motorimgcolor.visible=false
						motortext.visible = false
						
						root23.visible = false
						root24.visible = false
						root25.visible = false
						root26.visible = false
						cv.visible = true
						cv2.visible = false
						
						rectslidercw1.visible = false
						recslidertext.visible = false
						cw1.visible = false
						ccw1.visible = false
						rectslidercw2.visible = false
						cw2.visible = false
						ccw2.visible = false
						mainscreen.visible = false
						changetemp.visible = false
					}
				}
        	}

			FeatureButtonMain {
				id: tempbuttonmain
				text: qsTr("Temp")
				font.family : "Lato"
				font.pointSize : 45
				icon.name: "temp"
				icon.source : "temperature.png"
				Layout.fillHeight: true
				checked:true
				onClicked : {
					if (tempbuttonmain.text == "Temp") {
						temperature.visible = true
						temperaturecolor.visible = true
						temptext.visible = true
						root21.visible = false
						root22.visible = false
						waterimg.visible = false
						waterimgcolor.visible=false
						
						motorimg.visible = false
						motorimgcolor.visible=false
						motortext.visible = false
						watertext.visible = false
						
						root23.visible = true
						root24.visible = true
						root25.visible = false
						root26.visible = false
						cv.visible = false
						cv2.visible = true
						
						rectslidercw1.visible = false
						recslidertext.visible = false
						cw1.visible = false
						ccw1.visible = false
						rectslidercw2.visible = false
						cw2.visible = false
						ccw2.visible = false
						mainscreen.visible = false
						changetemp.visible = true
					}
				}
        	}

			FeatureButtonMain {
				id: motorbuttonmain
				text: qsTr("Motor")
				font.family : "Lato"
				font.pointSize : 45
				icon.name: "Led"
				icon.source : "motor.png"
				Layout.fillHeight: true
				checked:true
				onClicked : {
					if (motorbuttonmain.text == "Motor") {
						root25.visible = true
						root26.visible = true
						temperature.visible = false
						temperaturecolor.visible = false
						temptext.visible = false
						root23.visible = false
						root24.visible = false
						root21.visible = false
						root22.visible = false
						waterimg.visible = false
						waterimgcolor.visible=false
						
						watertext.visible = false
						motorimg.visible = true
						motorimgcolor.visible=true
						motortext.visible = true
						
						cv.visible = false
						cv2.visible = false
						
						rectslidercw1.visible = true
						recslidertext.visible = true
						cw1.visible = true
						ccw1.visible=true
						rectslidercw2.visible = true
						cw2.visible = true
						ccw2.visible = true
						mainscreen.visible = false
						changetemp.visible = false
					}
				}
        	}
		}
	}

	Rectangle{
		id:rootatas
		visible : true
		width : 1*root.width // 800
		height :0.07971 * width //47.826
		anchors.top : root.top
		gradient : Gradient{
			GradientStop { position : 0 ; color : "#00FFFF"}
			GradientStop { position : 1 ; color : "#010911"}
		}

		Image{
		id : syergie
		source : "syergielogofix.jpg"
		width : 0.10869 * rootatas.width //150
		height : 0.33333 * width //50
		anchors.top : rootatas.top
		anchors.left : rootatas.left
		anchors.topMargin : 35
		anchors.leftMargin : 60
		//x : 60
		//y : 35
		visible : true
	}

		Image{
			id : unpad
			source : "logo-unpad1.png"
			width : 0.06* rootatas.width //87
			height : 0.81609 * width //71
			//x : 250
			//y : 25
			anchors.top : rootatas.top
			anchors.left : syergie.right
			anchors.topMargin : 22
			anchors.leftMargin : 60
			visible : true
		}

		GlowingLabel {
			text: qsTr("Graphical User Interface")
			font.family : "Lato"
			color: "white"
			font.pointSize : 30
			anchors.centerIn : parent
			
		}

		Button {
			id : buttonquit
			anchors.right : rootatas.right
			anchors.top : rootatas.top
			anchors.rightMargin : 33
			anchors.topMargin : 40
			onClicked: Board.setquit("Quit Now")
			style : ButtonStyle{
				background:Rectangle { 
					id : recquit
					implicitWidth :  0.03623 * rootatas.width //50
					implicitHeight : implicitWidth
					color : control.pressed ? "#007676" : "transparent"
					border.color : "#00FFFF"
					border.width : 3
					radius : 50
					Image{
						id :quitimg
						width : 0.5 * recquit.implicitWidth
						height : width
						source : "quit"
						anchors.centerIn : parent
					}

					ColorOverlay{
						id:quitimgcolor
						visible:true
						anchors.fill : quitimg
						source : quitimg
						color : "#00FFFF"
					}
				}	
			}			
		}

		Button {
			id : buttonmini
			anchors.right : buttonquit.left
			anchors.top : rootatas.top
			anchors.rightMargin : 20
			anchors.topMargin : 40
			onClicked: Board.setmini("Minimize Now")
			style : ButtonStyle{
				background:Rectangle{
					id : recmini
					implicitWidth :  0.03623 * rootatas.width //50
					implicitHeight : implicitWidth //50
					color : control.pressed ? "#007676" : "transparent"
					border.color : "#00FFFF"
					border.width : 3
					radius : 50
					Image{
						id :miniimg
						width : 0.5 * recmini.implicitWidth //25
						height : width //25
						source : "mini"
						anchors.centerIn : parent
					}

					ColorOverlay{
						id:miniimgcolor
						visible:true
						anchors.fill : miniimg
						source : miniimg
						color : "#00FFFF"
					}
				}	
			}			
		}

        Button {
			id : buttonmax
			anchors.right : buttonmini.left
			anchors.top : rootatas.top
			anchors.rightMargin : 20
			anchors.topMargin : 40
            onClicked: Board.setmax("Maximize Now")
			style : ButtonStyle{
				background:Rectangle{
					id : recmax
					implicitWidth :  0.03623 * rootatas.width //50
					implicitHeight : implicitWidth //50
					color : control.pressed ? "#007676" : "transparent"
					border.color : "#00FFFF"
					border.width : 3
					radius : 50
					Image{
						id :maximg
						width : 0.5 * recmax.implicitWidth //25
						height : width //25
						source : "max"
						anchors.centerIn : parent
                        visible : true
					}

					ColorOverlay{
						id:maximgcolor
						visible:true
						anchors.fill : maximg
						source : maximg
						color : "#00FFFF"
					}
				}	
			} 			
		}
	}

	Rectangle {
		id: root1
		visible: true
		//x : 25
		//y : 125
		anchors.left : root.left
		anchors.top : root.top
		anchors.leftMargin : 25
		anchors.topMargin : 135
		width: 0.25362 * root.width //350
		height:1.7143 * width //600
		color: "#010911"
		border.color:"#00FFFF"
		border.width : 3
		radius : 2
		
		Row{
			id: rowbutton
            anchors.top : root1.top
			anchors.horizontalCenter : root1.horizontalCenter
            anchors.margins: 24
            spacing: 50
			

			FeatureButton {
				id: waterbutton
				text: qsTr("Water")
				font.family : "Lato"
				icon.name: "Watericon"
				icon.source : "water.png"
				Layout.fillHeight: true
				checked:true
				onClicked : {
					if (waterbutton.text == "Water"  ) {
						root21.visible = true
						root22.visible = true
						waterimg.visible = true
						waterimgcolor.visible=true
						watertext.visible = true
						temperature.visible = false
						temperaturecolor.visible = false
						temptext.visible = false
						motorimg.visible = false
						motorimgcolor.visible=false
						motortext.visible = false
						
						root23.visible = false
						root24.visible = false
						root25.visible = false
						root26.visible = false
						cv.visible = true
						cv2.visible = false
						cv3.visible=false
						changehum.visible=false
						changetemp.visible=false
						
						rectslidercw1.visible = false
						recslidertext.visible = false
						cw1.visible = false
						ccw1.visible = false
						rectslidercw2.visible = false
						cw2.visible = false
						ccw2.visible = false

					}
				}
        	}

			FeatureButton {
				id: tempbutton
				text: qsTr("Temp")
				font.family : "Lato"
				icon.name: "temp"
				icon.source : "temperature.png"
				Layout.fillHeight: true
				checked:true
				onClicked : {
					if (tempbutton.text == "Temp") {
						temperature.visible = true
						temperaturecolor.visible = true
						temptext.visible = true
						root21.visible = false
						root22.visible = false
						waterimg.visible = false
						waterimgcolor.visible=false
						
						motorimg.visible = false
						motorimgcolor.visible=false
						motortext.visible = false
						watertext.visible = false
						
						root23.visible = true
						root24.visible = true
						root25.visible = false
						root26.visible = false
						cv.visible = false
						cv2.visible = true
						cv3.visible=false
						changehum.visible=false
						changetemp.visible=true
						
						rectslidercw1.visible = false
						recslidertext.visible = false
						cw1.visible = false
						ccw1.visible = false
						rectslidercw2.visible = false
						cw2.visible = false
						ccw2.visible = false
						changetemp.visible = true

					}
				}
        	}

			FeatureButton {
				id: motorbutton
				text: qsTr("Motor")
				font.family : "Lato"
				icon.name: "Led"
				icon.source : "motor.png"
				Layout.fillHeight: true
				checked:true
				onClicked : {
					if (motorbutton.text == "Motor") {
						root25.visible = true
						root26.visible = true
						temperature.visible = false
						temperaturecolor.visible = false
						temptext.visible = false
						root23.visible = false
						root24.visible = false
						root21.visible = false
						root22.visible = false
						waterimg.visible = false
						waterimgcolor.visible=false
						
						watertext.visible = false
						motorimg.visible = true
						motorimgcolor.visible=true
						motortext.visible = true
						
						cv.visible = false
						cv2.visible = false
						cv3.visible=false
						changehum.visible=false
						changetemp.visible=false
						
						rectslidercw1.visible = true
						recslidertext.visible = true
						cw1.visible = true
						ccw1.visible=true
						rectslidercw2.visible = true
						cw2.visible = true
						ccw2.visible = true

					}
				}
        	}
		}

		GlowingLabel {
			id : statustext
			text: "Status :"
			font.family : "Lato"
			color: "white"
			font.pointSize : 30
			anchors.top : rowbutton.bottom
			anchors.horizontalCenter : rowbutton.horizontalCenter
			anchors.topMargin : 80
		}

		GlowingLabel {
			id : statusIndicator
			text: "OFF"
			font.family : "Lato"
			color: "white"
			font.pointSize : 60
			anchors.top : statustext.bottom
			anchors.horizontalCenter : statustext.horizontalCenter
			anchors.topMargin : 60
		}	
	}

	Rectangle{
		id: root4
		visible: true
		anchors.bottom : root1.bottom
		anchors.horizontalCenter : root1.horizontalCenter
		width: 0.25362 * root.width //350
		height: 0.5 * width //175
		color: "#010911"
		border.color:"#00FFFF"
		border.width : 3
		radius : 2
		Rectangle {
			id: recttext
			visible: true
			color: "#010911"
			anchors.centerIn : parent
			width : 300
			height : 100

			GlowingLabel{
				id:texttime
				font.family : "Lato"
				font.pointSize : 30
				anchors.horizontalCenter : recttext.horizontalCenter
				anchors.top : recttext.top
				anchors.topMargin : 25
			}

			GlowingLabel{
				id:texttime2
				font.family : "Lato"
				font.pointSize : 15
				anchors.top : texttime.bottom
				anchors.horizontalCenter : texttime.horizontalCenter
				anchors.topMargin : 15
			}

			Timer{
				interval : 500
				running : true
				repeat : true

				onTriggered:{
					var date = new Date()
					texttime.text = date.toLocaleTimeString(Qt.locale("en_US"), "hh:mm:ss ap")
					texttime2.text = date.toLocaleDateString(Qt.locale("en_US"))
				}
			}
		}
	}



	Rectangle {
		id: root2
		visible: true
		//x : 400
		//y : 125
		anchors.left : root1.right
		anchors.top : root.top
		anchors.leftMargin : 25
		anchors.topMargin : 135
		width: 0.68840 * root.width //950
		height: 0.3 * width //285
		color: "#010911"
		border.color:"#00FFFF"
		border.width : 3
		radius : 2
		

		Rectangle {
			id: root21
			visible: true
			anchors.left : root2.left
			anchors.leftMargin :75
			anchors.verticalCenter : root2.verticalCenter
			width: 0.24210 * root2.width //230
			height:width //230
			color: "#010911"

        	Text {
	            id: name1
	            text: "Flow Rate"
	            anchors.horizontalCenter: parent.horizontalCenter
	            anchors.top: parent.top
	            anchors.topMargin: 20
	            font.pointSize: 13
	            color: "#00FFFF"
	        }

	        RadialBar {
	        	id : radial1
	            anchors.horizontalCenter: parent.horizontalCenter
	            anchors.bottom: parent.bottom
	            width: parent.width / 1.4
	            height: width - (0.00000000001)
	            penStyle: Qt.RoundCap
	            progressColor: "#00FFFF"
	            foregroundColor: "#191a2f"
	            dialWidth: 11
				suffixText: suffix1
	            minValue: minVal1
	            maxValue: maxVal1
	            value: actVal1
				
	            textFont 
	            {
	                family: "Lato"
	                italic: false
	                pointSize: 18
	            }

	            textColor: "#00FFFF"
	        }	
		}

		Rectangle {
			id: root22
			visible: true
			anchors.right : root2.right
			anchors.rightMargin :75
			anchors.verticalCenter : root2.verticalCenter //230
			width: 0.24210 * root2.width //230
			height:width
			color: "#010911"

        	Text {
	            id: name2
	            text: "Total MiliLiter"
	            anchors.horizontalCenter: parent.horizontalCenter
	            anchors.top: parent.top
	            anchors.topMargin: 20
	            font.pointSize: 13
	            color: "#00FFFF"
				
	        }

	        RadialBar {
	        	id : radial2
	            anchors.horizontalCenter: parent.horizontalCenter
	            anchors.bottom: parent.bottom
	            width: parent.width / 1.4
	            height: width - (0.00000000001)
	            penStyle: Qt.RoundCap
	            progressColor: "#010911"
	            foregroundColor: "#010911"
	            dialWidth: 1
				suffixText: suffix2
	            minValue: minVal2
	            value: actVal2/1000
				
	            
	            textFont 
	            {
	                family: "Lato"
	                italic: false
	                pointSize: 18
	            }

	            textColor: "#00FFFF"
	        }	
		}

		Rectangle {
			id: root23
			visible: false
			anchors.left : root2.left
			anchors.leftMargin :75
			anchors.verticalCenter : root2.verticalCenter
			width: 0.24210 * root2.width //230
			height:width //230
			color: "#010911"

        	Text {
	            id: name3
	            text: "Temperature"
	            anchors.horizontalCenter: parent.horizontalCenter
	            anchors.top: parent.top
	            anchors.topMargin: 20
	            font.pointSize: 13
	            color: "#00FFFF"
	        }

	        RadialBar {
	        	id : radial3
	            anchors.horizontalCenter: parent.horizontalCenter
	            anchors.bottom: parent.bottom
	            width: parent.width / 1.4
	            height: width - (0.00000000001)
	            penStyle: Qt.RoundCap
	            progressColor: "#00FFFF"
	            foregroundColor: "#191a2f"
	            dialWidth: 11
				suffixText: suffix3
	            minValue: minVal3
	            maxValue: maxVal3
	            value: actVal3
				
	            textFont 
	            {
	                family: "Lato"
	                italic: false
	                pointSize: 18
	            }

	            textColor: "#00FFFF"
	        }	
		}

		Rectangle {
			id: root24
			visible: false
			anchors.right : root2.right
			anchors.rightMargin :75
			anchors.verticalCenter : root2.verticalCenter
			width: 0.24210 * root2.width //230
			height:width //230
			color: "#010911"

        	Text {
	            id: name4
	            text: "Humidity"
	            anchors.horizontalCenter: parent.horizontalCenter
	            anchors.top: parent.top
	            anchors.topMargin: 20
	            font.pointSize: 13
	            color: "#00FFFF"
	        }

	        RadialBar {
	        	id : radial4
	            anchors.horizontalCenter: parent.horizontalCenter
	            anchors.bottom: parent.bottom
	            width: parent.width / 1.4
	            height: width - (0.00000000001)
	            penStyle: Qt.RoundCap
	            progressColor: "#00FFFF"
	            foregroundColor: "#191a2f"
	            dialWidth: 11
				suffixText: suffix4
	            minValue: minVal4
	            maxValue: maxVal4
	            value: actVal4
				
	            textFont 
	            {
	                family: "Lato"
	                italic: false
	                pointSize: 18
	            }

	            textColor: "#00FFFF"
	        }	
		}

		Image{
			id : waterimg
			source : "water.png"
			width : 0.15789 * root2.width //150
			height :1 * width//150
			/*anchors.left : root2.left
			anchors.top : root2.top
			anchors.leftMargin : 450
			anchors.topMargin : 60
			*/
			anchors.centerIn : parent
			visible : true
		}

		ColorOverlay{
			id:waterimgcolor
			visible:true
			anchors.fill : waterimg
			source : waterimg
			color : "#00FFFF"
		}

		GlowingLabel {
			id : watertext
			visible : true
            text: "Water Flow Sensor"
			font.family : "Lato"
            color: "white"
            font.pointSize : 20
			anchors.top : waterimg.bottom
            anchors.horizontalCenter : waterimg.horizontalCenter
        }

		Image{
			id : temperature
			source : "temperature.png"
			width : 0.10152 * root2.width//100
			height : 1.11 * width//111
			//anchors.left : root2.left
			//anchors.top : root2.top
			//anchors.leftMargin : 430
			//anchors.topMargin : 50
			anchors.centerIn : parent
			visible : false
		}

		ColorOverlay{
			id:temperaturecolor
			visible:false
			anchors.fill : temperature
			source : temperature
			color : "#00FFFF"
		}

		GlowingLabel {
			id : temptext
			visible : false
            text: "Temperature & Humidity Sensor"
			font.family : "Lato"
            color: "white"
            font.pointSize : 20
			anchors.top : temperature.bottom
            anchors.horizontalCenter : temperature.horizontalCenter
            anchors.topMargin : 20
		}

		Image{
			id : motorimg
			source : "motor.png"
			width : 170/950 * root2.width //150
			height :120/170 * width//150
			/*anchors.left : root2.left
			anchors.top : root2.top
			anchors.leftMargin : 450
			anchors.topMargin : 60
			*/
			anchors.centerIn : parent
			visible : false
		}

		ColorOverlay{
			id:motorimgcolor
			visible:false
			anchors.fill : motorimg
			source : motorimg
			color : "#00FFFF"
		}

		GlowingLabel {
			id : motortext
			visible : false
            text: "DC Motor Speed"
			font.family : "Lato"
            color: "white"
            font.pointSize : 20
			anchors.top : motorimg.bottom
            anchors.horizontalCenter : motorimg.horizontalCenter
			anchors.topMargin : 15
        }

		Rectangle {
			id: root25
			visible: false
			anchors.left : root2.left
			anchors.leftMargin :75
			anchors.verticalCenter : root2.verticalCenter
			width: 0.24210 * root2.width //230
			height:width //230
			color: "#010911"

        	Text {
	            id: name5
	            text: "DC Motor 1"
	            anchors.horizontalCenter: parent.horizontalCenter
	            anchors.top: parent.top
	            anchors.topMargin: 20
	            font.pointSize: 13
	            color: "#00FFFF"
	        }

	        RadialBar {
	        	id : radial5
	            anchors.horizontalCenter: parent.horizontalCenter
	            anchors.bottom: parent.bottom
	            width: parent.width / 1.4
	            height: width - (0.00000000001)
	            penStyle: Qt.RoundCap
	            progressColor: "#00FFFF"
	            foregroundColor: "#191a2f"
	            dialWidth: 11
				suffixText: suffix5
	            minValue: minVal5
	            maxValue: maxVal5
	            value: Math.floor(slidercw1.value)
				
	            textFont 
	            {
	                family: "Lato"
	                italic: false
	                pointSize: 18
	            }

	            textColor: "#00FFFF"
	        }	
		}

		Rectangle {
			id: root251
			visible: false
			anchors.left : root2.left
			anchors.leftMargin :75
			anchors.verticalCenter : root2.verticalCenter
			width: 0.24210 * root2.width //230
			height:width //230
			color: "#010911"

        	Text {
	            id: name51
	            text: "DC Motor 1"
	            anchors.horizontalCenter: parent.horizontalCenter
	            anchors.top: parent.top
	            anchors.topMargin: 20
	            font.pointSize: 13
	            color: "#00FFFF"
	        }

	        RadialBar {
	        	id : radial51
	            anchors.horizontalCenter: parent.horizontalCenter
	            anchors.bottom: parent.bottom
	            width: parent.width / 1.4
	            height: width - (0.00000000001)
	            penStyle: Qt.RoundCap
	            progressColor: "#00FFFF"
	            foregroundColor: "#191a2f"
	            dialWidth: 11
				suffixText: suffix5
	            minValue: minVal5
	            maxValue: maxVal5
	            value: Math.floor(sliderccw1.value)
				
	            textFont 
	            {
	                family: "Lato"
	                italic: false
	                pointSize: 18
	            }

	            textColor: "#00FFFF"
	        }	
		}

		Rectangle {
			id: root26
			visible: false
			anchors.right : root2.right
			anchors.rightMargin :75
			anchors.verticalCenter : root2.verticalCenter //230
			width: 0.24210 * root2.width //230
			height:width
			color: "#010911"

        	Text {
	            id: name6
	            text: "DC Motor 2"
	            anchors.horizontalCenter: parent.horizontalCenter
	            anchors.top: parent.top
	            anchors.topMargin: 20
	            font.pointSize: 13
	            color: "#00FFFF"
				
	        }

	        RadialBar {
	        	id : radial6
	            anchors.horizontalCenter: parent.horizontalCenter
	            anchors.bottom: parent.bottom
	            width: parent.width / 1.4
	            height: width - (0.00000000001)
	            penStyle: Qt.RoundCap
	            progressColor: "#00FFFF"
	            foregroundColor: "#191a2f"
	            dialWidth: 11
				suffixText: suffix6
	            minValue: minVal6
	            maxValue: maxVal6
	            value: Math.floor(slidercw2.value)
				
	            
	            textFont 
	            {
	                family: "Lato"
	                italic: false
	                pointSize: 18
	            }

	            textColor: "#00FFFF"
	        }	
		}

		Rectangle {
			id: root261
			visible: false
			anchors.right : root2.right
			anchors.rightMargin :75
			anchors.verticalCenter : root2.verticalCenter //230
			width: 0.24210 * root2.width //230
			height:width
			color: "#010911"

        	Text {
	            id: name61
	            text: "DC Motor 2"
	            anchors.horizontalCenter: parent.horizontalCenter
	            anchors.top: parent.top
	            anchors.topMargin: 20
	            font.pointSize: 13
	            color: "#00FFFF"
				
	        }

	        RadialBar {
	        	id : radial61
	            anchors.horizontalCenter: parent.horizontalCenter
	            anchors.bottom: parent.bottom
	            width: parent.width / 1.4
	            height: width - (0.00000000001)
	            penStyle: Qt.RoundCap
	            progressColor: "#00FFFF"
	            foregroundColor: "#191a2f"
	            dialWidth: 11
				suffixText: suffix6
	            minValue: minVal6
	            maxValue: maxVal6
	            value: Math.floor(sliderccw2.value)
				
	            
	            textFont 
	            {
	                family: "Lato"
	                italic: false
	                pointSize: 18
	            }

	            textColor: "#00FFFF"
	        }	
		}					
	}

	Rectangle {
		id: root3
		visible: true
		//x : 400
		//y : 415
		anchors.left : root1.right
		anchors.top : root2.bottom
		anchors.leftMargin : 25
		anchors.topMargin : 30.5
		width: 0.68840 * root.width //950
		height:0.3 * width //285
		color: "#010911"
		border.color: "#00FFFF"
		border.width : 3
		radius : 2

		ChartView {
			id : cv
			title: "Water Flow System"
			titleColor : "white"
			titleFont.pointSize : 20
			antialiasing: true
			legend.visible: true
			height: parent.height
			anchors.right: parent.right
			anchors.left: parent.left
			theme: ChartView.ChartThemeBlueCerulean
            
		
			property int  timcnt: 0
			property double  valueCH1: 0
			property double  valueCH2: 0
			property double  valueCH3: 0
			property double  valueCH4: 0
			//property double  valueTM1: 0        
			property double  periodGRAPH: 30 // Seconds
			property double  startTIME: 0
			property double  intervalTM: 200 // miliseconds

			ValueAxis{
				id:yAxis
				titleText:"Flow Rate (L)"
				min: 0
				max: 15
				tickCount: 1
				labelFormat: "%d"
			}

			LineSeries {
				name: "Flow Rate"
				id:lines1
				//axisX: xAxis
				axisY: yAxis
				width: 3
				color: "#00FFFF"
				axisX: 	DateTimeAxis {
							id: eje
							//format: "yyyy MMM"
							format : "hh:mm:ss"
							//format:"mm:ss.z"
							titleText:"Time"
				}
			}
						
			Timer{
				id:tm
				interval: cv.intervalTM
				repeat: true
				running: true
				onTriggered: {
					cv.timcnt = cv.timcnt + 1
					//cv.valueTM1 = board.get_time()*1000
					cv.valueCH1 = radial1.value
					cv.valueCH2 = radial2.value
					cv.valueCH3 = 70
					cv.valueCH4 = 100
					 
					lines1.append(cv.startTIME+cv.timcnt*cv.intervalTM ,cv.valueCH1)
					
					//lines3.append(cv.startTIME+cv.timcnt*cv.intervalTM ,cv.valueCH3)
					//lines4.append(cv.startTIME+cv.timcnt*cv.intervalTM ,cv.valueCH4)
					
					//lines1.append(cv.valueTM1+cv.timcnt*500 ,cv.valueCH1)
					//lines2.append(cv.valueTM1+cv.timcnt*500 ,cv.valueCH2)
					//lines3.append(cv.valueTM1+cv.timcnt*500 ,cv.valueCH3)
					//lines4.append(cv.valueTM1+cv.timcnt*500 ,cv.valueCH4)
					
					//lines1.axisX.min = cv.timcnt < cv.periodGRAPH ? new Date(cv.startTIME) : new Date(cv.startTIME  - cv.periodGRAPH*1000 + cv.timcnt*1000)
					//lines1.axisX.max = cv.timcnt < cv.periodGRAPH ? new Date(cv.startTIME  + cv.periodGRAPH*1000) : new Date(cv.startTIME   + cv.timcnt*1000)
					
					//lines1.axisX.min = new Date(cv.startTIME-cv.periodGRAPH*1000 + cv.timcnt*500)
					//lines1.axisX.max = new Date(cv.startTIME + cv.timcnt*500)
					
					lines1.axisX.min = new Date(cv.startTIME-cv.periodGRAPH*1000 + cv.timcnt*cv.intervalTM)//.toLocaleTimeString(Qt.locale("en_US"), "hh:mm:ss")
					lines1.axisX.max = new Date(cv.startTIME + cv.timcnt*cv.intervalTM)//.toLocaleTimeString(Qt.locale("en_US"))
					//lines1.axisX.min = new Date(cv.startTIME-cv.periodGRAPH*1000 + cv.timcnt*cv.intervalTM)
					//lines1.axisX.max = new Date(cv.startTIME + cv.timcnt*cv.intervalTM)

				}
			}
		}

		ChartView {
			id : cv2
			title: "Temperature Sistem"
			titleColor : "white"
			titleFont.pointSize : 20
			visible : false
			antialiasing: true
			legend.visible: true
			height: parent.height
			anchors.right: parent.right
			anchors.left: parent.left
			theme: ChartView.ChartThemeBlueCerulean
		
			property int  timcnt: 0
			property double  valueCH1: 0
			property double  valueCH2: 0
			property double  valueCH3: 0
			property double  valueCH4: 0
			//property double  valueTM1: 0        
			property double  periodGRAPH: 30 // Seconds
			property double  startTIME: 0
			property double  intervalTM: 200 // miliseconds

			ValueAxis{
				id:yAxis1
				min: 0
				max: 55
				tickCount: 1
				labelFormat: "%d"
				titleText:"Temperature (°C)"
			}
		
		
			LineSeries {
				name: "Temperature"
				id:lines3
				//axisX: xAxis
				axisY: yAxis1
				width: 3
				color: "#00FFFF"
				axisX: 	DateTimeAxis {
							id: eje1
							format : "hh:mm:ss"
							titleText:"Time"
						}
			}
			
				
			Timer{
				id:tmm
				interval: cv2.intervalTM
				repeat: true
				running: true
				onTriggered: {
					cv2.timcnt = cv2.timcnt + 1
					//cv.valueTM1 = backend.get_time()*1000
					cv2.valueCH1 = radial3.value
					cv2.valueCH2 = radial4.value
					cv2.valueCH3 = 70
					cv2.valueCH4 = 100
					
					
					
					lines3.append(cv2.startTIME+cv2.timcnt*cv2.intervalTM ,cv2.valueCH1)
					///lines3.append(cv.startTIME+cv.timcnt*cv.intervalTM ,cv.valueCH3)
					//lines4.append(cv.startTIME+cv.timcnt*cv.intervalTM ,cv.valueCH4)
					
					//lines1.append(cv.valueTM1+cv.timcnt*500 ,cv.valueCH1)
					//lines2.append(cv.valueTM1+cv.timcnt*500 ,cv.valueCH2)
					//lines3.append(cv.valueTM1+cv.timcnt*500 ,cv.valueCH3)
					//lines4.append(cv.valueTM1+cv.timcnt*500 ,cv.valueCH4)
					
					//lines3.axisX.min = cv.timcnt < cv.periodGRAPH ? new Date(cv.startTIME) : new Date(cv.startTIME  - cv.periodGRAPH*1000 + cv.timcnt*1000)
					//lines3.axisX.max = cv.timcnt < cv.periodGRAPH ? new Date(cv.startTIME  + cv.periodGRAPH*1000) : new Date(cv.startTIME   + cv.timcnt*1000)
					
					//lines3.axisX.min = new Date(cv.startTIME-cv.periodGRAPH*1000 + cv.timcnt*500)
					//lines3.axisX.max = new Date(cv.startTIME + cv.timcnt*500)
					
					lines3.axisX.min = new Date(cv2.startTIME-cv2.periodGRAPH*1000 + cv2.timcnt*cv2.intervalTM)//.toLocaleTimeString(Qt.locale("en_US"), "hh:mm:ss")
					lines3.axisX.max = new Date(cv2.startTIME + cv2.timcnt*cv2.intervalTM)//.toLocaleTimeString(Qt.locale("en_US"), "hh:mm:ss")

					//lines3.axisX.min = new Date(cv.startTIME-cv.periodGRAPH*1000 + cv.timcnt*cv.intervalTM)
					//lines3.axisX.max = new Date(cv.startTIME + cv.timcnt*cv.intervalTM)
				}
			}
		}

		Button{
			id:changehum
			visible : false
			text : qsTr("Change")
			Layout.fillHeight: true
			anchors.right : root3.right
			anchors.top : root3.top
			anchors.rightMargin:10
			anchors.topMargin:10
			opacity : 1

			style : ButtonStyle{
				background:Rectangle{
					implicitWidth : 25/950 * root3.width
					implicitHeight : 0.5*implicitWidth
					opacity : 1
					gradient : Gradient{
						GradientStop { position : 0 ; color : control.pressed ? "#007676" : "#00FFFF"}
						GradientStop { position : 1 ; color : control.pressed ? "#010911" : "#010911"}
					}
				}	
				label : Text{
					font.pointSize : 25
					renderType: Text.NativeRendering
       				verticalAlignment: Text.AlignVCenter
					horizontalAlignment: Text.AlignHCenter
					color : "white"
					font.family : "Lato"
					text: control.text
				}
			}

			onClicked : {
				cv3.visible=false
				cv2.visible=true
				changehum.visible=false
				changetemp.visible=true
				changetemp.z=1
			}
		}

		Button{
			id:changetemp
			visible : false
			text : qsTr("Change")
			Layout.fillHeight: true
			anchors.right : root3.right
			anchors.top : root3.top
			anchors.rightMargin:10
			anchors.topMargin:10
			opacity : 1

			style : ButtonStyle{
				background:Rectangle{
					implicitWidth : 120/950 * parent.width
					implicitHeight : 0.5*implicitWidth
					opacity : 1
					gradient : Gradient{
						GradientStop { position : 0 ; color : control.pressed ? "#007676" : "#00FFFF"}
						GradientStop { position : 1 ; color : control.pressed ? "#010911" : "#010911"}
					}
				}	
				label : Text{
					font.pointSize : 25
					renderType: Text.NativeRendering
       				verticalAlignment: Text.AlignVCenter
					horizontalAlignment: Text.AlignHCenter
					color : "white"
					font.family : "Lato"
					text: control.text
				}
			}

			onClicked : {
				cv3.visible=true
				cv2.visible=false
				changetemp.visible=false
				changehum.visible=true
				changehum.z=1
			}
		}

		ChartView {
			id : cv3
			title: "Humidity Sistem"
			titleColor : "white"
			titleFont.pointSize : 20
			visible : false
			antialiasing: true
			legend.visible: true
			height: parent.height
			anchors.right: parent.right
			anchors.left: parent.left
			theme: ChartView.ChartThemeBlueCerulean
		
			property int  timcnt: 0
			property double  valueCH1: 0
			property double  valueCH2: 0
			property double  valueCH3: 0
			property double  valueCH4: 0
			//property double  valueTM1: 0        
			property double  periodGRAPH: 30 // Seconds
			property double  startTIME: 0
			property double  intervalTM: 200 // miliseconds

			ValueAxis{
				id:yAxis2
				min: 15
				max: 95
				tickCount: 1
				labelFormat: "%d"
				titleText:"Humidity (RH)"
			}
		
		
			LineSeries {
				name: "Humidity"
				id:lines4
				//axisX: xAxis
				axisY: yAxis2
				width: 3
				color: "#00FFFF"
				axisX: 	DateTimeAxis {
							id: eje2
							format : "hh:mm:ss"
							titleText:"Time"
						}
			}
			
			
			Timer{
				id:tmmm
				interval: cv3.intervalTM
				repeat: true
				running: true
				onTriggered: {
					cv3.timcnt = cv3.timcnt + 1
					//cv.valueTM1 = backend.get_time()*1000
					cv3.valueCH1 = radial3.value
					cv3.valueCH2 = radial4.value
					cv3.valueCH3 = 70
					cv3.valueCH4 = 100
					
					
					lines4.append(cv3.startTIME+cv3.timcnt*cv3.intervalTM ,cv3.valueCH2)
					///lines3.append(cv.startTIME+cv.timcnt*cv.intervalTM ,cv.valueCH3)
					//lines4.append(cv.startTIME+cv.timcnt*cv.intervalTM ,cv.valueCH4)
					
					//lines1.append(cv.valueTM1+cv.timcnt*500 ,cv.valueCH1)
					//lines2.append(cv.valueTM1+cv.timcnt*500 ,cv.valueCH2)
					//lines3.append(cv.valueTM1+cv.timcnt*500 ,cv.valueCH3)
					//lines4.append(cv.valueTM1+cv.timcnt*500 ,cv.valueCH4)
					
					//lines3.axisX.min = cv.timcnt < cv.periodGRAPH ? new Date(cv.startTIME) : new Date(cv.startTIME  - cv.periodGRAPH*1000 + cv.timcnt*1000)
					//lines3.axisX.max = cv.timcnt < cv.periodGRAPH ? new Date(cv.startTIME  + cv.periodGRAPH*1000) : new Date(cv.startTIME   + cv.timcnt*1000)
					
					//lines3.axisX.min = new Date(cv.startTIME-cv.periodGRAPH*1000 + cv.timcnt*500)
					//lines3.axisX.max = new Date(cv.startTIME + cv.timcnt*500)
					
					lines4.axisX.min = new Date(cv3.startTIME-cv3.periodGRAPH*1000 + cv3.timcnt*cv3.intervalTM)//.toLocaleTimeString(Qt.locale("en_US"), "hh:mm:ss")
					lines4.axisX.max = new Date(cv3.startTIME + cv3.timcnt*cv3.intervalTM)//.toLocaleTimeString(Qt.locale("en_US"), "hh:mm:ss")

					//lines3.axisX.min = new Date(cv.startTIME-cv.periodGRAPH*1000 + cv.timcnt*cv.intervalTM)
					//lines3.axisX.max = new Date(cv.startTIME + cv.timcnt*cv.intervalTM)
				}
			}
		}

		Rectangle{
			id : rectslidercw1
			color : "#010911"
			width : 0.52631 * root3.width//500
			height : 0.1 * width//50
			anchors.left : root3.left
			anchors.bottom : root3.bottom
			anchors.leftMargin : 50
			anchors.bottomMargin : 125
			visible : false

			Slider{
				id : slidercw1
				anchors.centerIn : parent
				maximumValue : 255
				minimumValue : 0
				stepSize : 1
				height : 0.125 * width//50
				width : 0.8 * rectslidercw1.width//400
				style: SliderStyle {
					groove: Rectangle {
					implicitHeight: 0.5 * implicitWidth//10
					implicitWidth: 0.05 * slidercw1.width//20
					radius: 8
					color : "#00FFFF"
					}

					handle: Rectangle {
						anchors.centerIn: parent
						color: control.pressed ? "#007676" : "#1d6d64"
						implicitWidth: 24
						implicitHeight: 24
						radius: 12
					}
				}
				onValueChanged: {
					Board.setslidercw1(value)
				}
			}	
		}

		Rectangle{
			id : rectsliderccw1
			color : "#010911"
			width : 0.52631 * root3.width//500
			height : 0.1 * width//50
			anchors.left : root3.left
			anchors.bottom : root3.bottom
			anchors.leftMargin : 50
			anchors.bottomMargin : 125
			visible : false

			Slider{
				id : sliderccw1
				anchors.centerIn : parent
				maximumValue : 255
				minimumValue : 0
				stepSize : 1
				height : 0.125 * width//50
				width : 0.8 * rectsliderccw1.width//400
				style: SliderStyle {
					groove: Rectangle {
					implicitHeight: 0.5 * implicitWidth//10
					implicitWidth: 0.05 * sliderccw1.width//20
					radius: 8
					color : "#00FFFF"
					}

					handle: Rectangle {
						anchors.centerIn: parent
						color: control.pressed ? "#007676" : "#1d6d64"
						implicitWidth: 24
						implicitHeight: 24
						radius: 12
					}
				}
				onValueChanged: {
					Board.setsliderccw1(value)
				}
			}	
		}

		Rectangle{
			id : rectslidercw2
			color : "#010911"
			width : 0.52631 * root3.width//500
			height : 0.1 * width//50
			anchors.left : root3.left
			anchors.bottom : root3.bottom
			anchors.leftMargin : 50
			anchors.bottomMargin : 50
			visible : false

			Slider{
				id : slidercw2
				anchors.centerIn : parent
				maximumValue : 255
				minimumValue : 0
				stepSize : 1
				height : 0.125 * width//50
				width : 0.8 * rectslidercw2.width//400
				style: SliderStyle {
					groove: Rectangle {
					implicitHeight: 0.5 * implicitWidth//10
					implicitWidth: 0.05 * slidercw2.width//20
					radius: 8
					color : "#00FFFF"
					}

					handle: Rectangle {
						anchors.centerIn: parent
						color: control.pressed ? "#007676" : "#1d6d64"
						implicitWidth: 24
						implicitHeight: 24
						radius: 12
					}
				}
				onValueChanged: {
					Board.setslidercw2(value)
				}
			}	
		}

		Rectangle{
			id : rectsliderccw2
			color : "#010911"
			width : 0.52631 * root3.width//500
			height : 0.1 * width//50
			anchors.left : root3.left
			anchors.bottom : root3.bottom
			anchors.leftMargin : 50
			anchors.bottomMargin : 50
			visible : false

			Slider{
				id : sliderccw2
				anchors.centerIn : parent
				maximumValue : 255
				minimumValue : 0
				stepSize : 1
				height : 0.125 * width//50
				width : 0.8 * rectsliderccw2.width//400
				style: SliderStyle {
					groove: Rectangle {
					implicitHeight: 0.5 * implicitWidth//10
					implicitWidth: 0.05 * sliderccw2.width//20
					radius: 8
					color : "#00FFFF"
					}

					handle: Rectangle {
						anchors.centerIn: parent
						color: control.pressed ? "#007676" : "#1d6d64"
						implicitWidth: 24
						implicitHeight: 24
						radius: 12
					}
				}
				onValueChanged: {
					Board.setsliderccw2(value)
				}
			}	
		}

		Rectangle{
			id : recslidertext
			color : "#010911"
			width : 270
			height : 38
			visible : false
			anchors.horizontalCenter: parent.horizontalCenter
	        anchors.top: parent.top
			anchors.topMargin: 40
	
			GlowingLabel {
                text: qsTr("DC Motor Control")
				font.family : "Lato"
                color: "white"
                font.pointSize : 30
				anchors.centerIn : parent
            }
		}

		Button{
			id:cw1
			visible : false
			text : qsTr("CW")
			Layout.fillHeight: true
			anchors.right : root3.right
			anchors.bottom : root3.bottom
			anchors.bottomMargin : 125
			anchors.rightMargin : 60
			opacity : 1

			style : ButtonStyle{
				background:Rectangle{
					implicitWidth : 120/950 * root3.width
					implicitHeight : 0.5*width
					opacity : 1
					gradient : Gradient{
						GradientStop { position : 0 ; color : control.pressed ? "#007676" : "#00FFFF"}
						GradientStop { position : 1 ; color : control.pressed ? "#010911" : "#010911"}
					}
				}	
				label : Text{
					font.pointSize : 20
					renderType: Text.NativeRendering
       				verticalAlignment: Text.AlignVCenter
					horizontalAlignment: Text.AlignHCenter
					color : "white"
					font.family : "Lato"
					text: control.text
				}
			}

			onClicked : {
				cw1.opacity = 1
				ccw1.opacity = 0.2
				slidercw1.value = 0
				sliderccw1.value = 0
				rectsliderccw1.visible = false
				rectslidercw1.visible = true
				root251.visible = false
				root25.visible = true
			}
		}

		Button{
			id:ccw1
			visible : false
			text : qsTr("CCW")
			Layout.fillHeight: true
			anchors.right : cw1.left
			anchors.bottom : root3.bottom
			anchors.bottomMargin : 125
			anchors.rightMargin : 50
			opacity : 0.2

			style : ButtonStyle{
				background:Rectangle{
					implicitWidth : 120/950 * root3.width
					implicitHeight : 0.5*width
					gradient : Gradient{
						GradientStop { position : 0 ; color : control.pressed ? "#007676" : "#00FFFF"}
						GradientStop { position : 1 ; color : control.pressed ? "#010911" : "#010911"}
					}
				}	
				label : Text{
					font.pointSize : 20
					renderType: Text.NativeRendering
       				verticalAlignment: Text.AlignVCenter
					horizontalAlignment: Text.AlignHCenter
					color : "white"
					font.family : "Lato"
					text: control.text
				}
			}
			onClicked : {
				cw1.opacity = 0.2
				ccw1.opacity = 1
				slidercw1.value = 0
				sliderccw1.value = 0
				rectsliderccw1.visible = true
				rectslidercw1.visible = false
				root251.visible = true
				root25.visible = false
			}
		}

		Button{
			id:cw2
			visible : false
			text : qsTr("CW")
			Layout.fillHeight: true
			anchors.right : root3.right
			anchors.bottom : root3.bottom
			anchors.bottomMargin : 50
			anchors.rightMargin : 60
			opacity : 1

			style : ButtonStyle{
				background:Rectangle{
					implicitWidth : 120/950 * root3.width
					implicitHeight : 0.5*width
					opacity : 1
					gradient : Gradient{
						GradientStop { position : 0 ; color : control.pressed ? "#007676" : "#00FFFF"}
						GradientStop { position : 1 ; color : control.pressed ? "#010911" : "#010911"}
					}
				}	
				label : Text{
					font.pointSize : 20
					renderType: Text.NativeRendering
       				verticalAlignment: Text.AlignVCenter
					horizontalAlignment: Text.AlignHCenter
					color : "white"
					font.family : "Lato"
					text: control.text
				}
			}

			onClicked : {
				cw2.opacity = 1
				ccw2.opacity = 0.2
				slidercw2.value = 0
				sliderccw2.value = 0
				rectsliderccw2.visible = false
				rectslidercw2.visible = true
				root261.visible = false
				root26.visible = true
			}
		}

		Button{
			id:ccw2
			visible : false
			text : qsTr("CCW")
			Layout.fillHeight: true
			anchors.right : cw1.left
			anchors.bottom : root3.bottom
			anchors.bottomMargin : 50
			anchors.rightMargin : 50
			opacity : 0.2

			style : ButtonStyle{
				background:Rectangle{
					implicitWidth : 120/950 * root3.width
					implicitHeight : 0.5*width
					gradient : Gradient{
						GradientStop { position : 0 ; color : control.pressed ? "#007676" : "#00FFFF"}
						GradientStop { position : 1 ; color : control.pressed ? "#010911" : "#010911"}
					}
				}	
				label : Text{
					font.pointSize : 20
					renderType: Text.NativeRendering
       				verticalAlignment: Text.AlignVCenter
					horizontalAlignment: Text.AlignHCenter
					color : "white"
					font.family : "Lato"
					text: control.text
				}
			}
			onClicked : {
				cw2.opacity = 0.2
				ccw2.opacity = 1
				slidercw2.value = 0
				sliderccw2.value = 0
				rectsliderccw2.visible = true
				rectslidercw2.visible = false
				root261.visible = true
				root26.visible = false
			}
		}	
	}
}