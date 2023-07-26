DESCRIPTION = "Startup and config files for use with BCM43XX WIFI and Bluetooth"

LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"

SRC_URI = " \
	file://bcm43xx-wifi \
	file://bcm43xx-bt \
"

FILES:${PN} = " \ 
	${sysconfdir}/wifi/variscite-wifi.d  \
	${sysconfdir}/bluetooth/variscite-bt.d*  \
"

RDEPENDS:${PN}:imx6ul-var-dart = "i2c-tools"
RDEPENDS:${PN}:imx8mq-var-dart = "i2c-tools"
RDEPENDS:${PN}:imx8mm-var-dart = "i2c-tools"
RDEPENDS:${PN}:imx8mn-var-som = "i2c-tools"
RDEPENDS:${PN}:imx8mp-var-dart = "i2c-tools"
RDEPENDS:${PN}:imx93-var-som = "i2c-tools"
RDEPENDS:${PN}:append = " base-files libgpiod-tools var-gpio-utils var-wireless-utils"

S = "${WORKDIR}"

do_install() {
	install -d ${D}${sysconfdir}/wifi/variscite-wifi.d
	install -m 0755 ${WORKDIR}/bcm43xx-wifi ${D}/${sysconfdir}/wifi/variscite-wifi.d

	install -d ${D}${sysconfdir}/bluetooth/variscite-bt.d
	install -m 0755 ${WORKDIR}/bcm43xx-bt ${D}/${sysconfdir}/bluetooth/variscite-bt.d
}

COMPATIBLE_MACHINE = "(imx6ul-var-dart|imx7-var-som|imx8mm-var-dart|imx8mn-var-som|imx8mq-var-dart|imx8qm-var-som|imx8qxp-var-som|imx8qxpb0-var-som|imx8mp-var-dart|imx93-var-som)"
