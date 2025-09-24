import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.20 as Kirigami

Item {
    id: configGeneral

    property alias cfg_wattageWarningThreshold: wattageWarningThresholdSpinBox.value
    property alias cfg_isWattageWarningThreshold: wattageWarningThresholdSwitch.checked

    property alias cfg_wattageThreshold: wattageThresholdSpinBox.value
    property alias cfg_isWattageThreshold: wattageThresholdSwitch.checked

    property alias cfg_chargeThreshold: chargeThresholdSpinBox.value
    property alias cfg_isChargeThreshold: chargeThresholdSwitch.checked

    property alias cfg_timeThreshold: timeThresholdSpinBox.value
    property alias cfg_isTimeThreshold: timeThresholdSwitch.checked

    property alias cfg_fontSize: fontSizeSpinBox.value
    property alias cfg_fontBold: fontBoldCheckBox.checked
    property alias cfg_fontFamily: fontFamilyComboBox.currentText
    property alias cfg_updateInterval: updateIntervalSpinBox.value

    Kirigami.FormLayout {
        anchors.left: parent.left
        anchors.right: parent.right

        QQC2.Switch {
            id: wattageWarningThresholdSwitch
            Kirigami.FormData.label: i18n("Warn on wattage:")
            checked: plasmoid.configuration.isWattageWarningThreshold
        }

        QQC2.SpinBox {
          id: wattageWarningThresholdSpinBox
          Kirigami.FormData.label: i18n("Threshold for yellow color on battery (W):")
          from: 0
          to: wattageThresholdSpinBox.value
          stepSize: wattageWarningThreshold.checked ? 1 : 0
          value: plasmoid.configuration.wattageWarningThreshold
          editable: wattageWarningThresholdSwitch.checked

          textFromValue: function(value, locale) {
            return value.toLocaleString(locale, 'f', 1)
          }

          valueFromText: function(text, locale) {
            return Number.fromLocaleString(locale, text)
          }
        }


        QQC2.Switch {
          id: wattageThresholdSwitch
          Kirigami.FormData.label: i18n("Recolor on wattage:")
          checked: plasmoid.configuration.isWattageThreshold
        }

        QQC2.SpinBox {
            id: wattageThresholdSpinBox
            Kirigami.FormData.label: i18n("Threshold for red color on battery (W):")
            from: 0
            to: 100
            stepSize: wattageThresholdSwitch.checked ? 1 : 0
            value: plasmoid.configuration.wattageThreshold
            editable: wattageThresholdSwitch.checked

            textFromValue: function(value, locale) {
                return value.toLocaleString(locale, 'f', 1)
            }

            valueFromText: function(text, locale) {
                return Number.fromLocaleString(locale, text)
            }
        }


        QQC2.Switch {
          id: chargeThresholdSwitch
          Kirigami.FormData.label: i18n("Recolor on percentage:")
          checked: plasmoid.configuration.isChargeThreshold
        }

        QQC2.SpinBox {
          id: chargeThresholdSpinBox
          Kirigami.FormData.label: i18n("Threshold for red color on battery (%):")
          from: 0
          to: 100
          stepSize: chargeThresholdSwitch.checked ? 1 : 0
          value: plasmoid.configuration.chargeThreshold
          editable: chargeThresholdSwitch.checked

          textFromValue: function(value, locale) {
            return value.toLocaleString(locale, 'f', 1)
          }

          valueFromText: function(text, locale) {
            return Number.fromLocaleString(locale, text)
          }
        }


        QQC2.Switch {
          id: timeThresholdSwitch
          Kirigami.FormData.label: i18n("Recolor on time:")
          checked: plasmoid.configuration.isTimeThreshold
        }

        QQC2.SpinBox {
          id: timeThresholdSpinBox
          Kirigami.FormData.label: i18n("Threshold for red color on battery (minutes):")
          from: 0
          to: 999
          stepSize: timeThresholdSwitch.checked ? 1 : 0
          value: plasmoid.configuration.timeThreshold
          editable: timeThresholdSwitch.checked

          textFromValue: function(value, locale) {
            return value.toLocaleString(locale, 'f', 1)
          }

          valueFromText: function(text, locale) {
            return Number.fromLocaleString(locale, text)
          }
        }


        QQC2.SpinBox {
            id: fontSizeSpinBox
            Kirigami.FormData.label: i18n("Font size:")
            from: 6
            to: 72
            value: plasmoid.configuration.fontSize
        }

        QQC2.CheckBox {
            id: fontBoldCheckBox
            text: i18n("Bold font")
            checked: plasmoid.configuration.fontBold
        }
        
QQC2.ComboBox {
    id: fontFamilyComboBox
    Kirigami.FormData.label: i18n("Font:")
    property string systemDefaultText: i18n("Default")
    model: [systemDefaultText].concat(Qt.fontFamilies())
    currentIndex: {
        if (plasmoid.configuration.fontFamily === "") {
            return 0;
        } else {
            var index = model.indexOf(plasmoid.configuration.fontFamily);
            return index !== -1 ? index : 0;
        }
    }
    onActivated: cfg_fontFamily = currentText === systemDefaultText ? "" : currentText
}

        QQC2.SpinBox {
            id: updateIntervalSpinBox
            Kirigami.FormData.label: i18n("Update interval (ms):")
            from: 500
            to: 60000
            stepSize: 500
            value: plasmoid.configuration.updateInterval
        }
    }
}
