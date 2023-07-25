DESCRIPTION = "Startup and config files for use with IW612 WIFI, Bluetooth, and 802.15.4"

LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"

DEPENDS += "${@bb.utils.contains('DISTRO_FEATURES','systemd','','update-rc.d-native',d)}"

SRC_URI = " \
	file://variscite-ot \
	file://variscite-ot.service \
"

FILES:${PN} = " \
	${sysconfdir}/openthread/*  \
"

RDEPENDS_${PN} = " \
    ot-daemon \
    i2c-tools \
    base-files \
    libgpiod-tools \
    var-gpio-utils \
"

S = "${WORKDIR}"

do_install() {
	install -d ${D}${sysconfdir}/openthread
	install -m 0755 ${WORKDIR}/variscite-ot ${D}/${sysconfdir}/openthread

	install -d ${D}${systemd_unitdir}/system
	install -d ${D}${sysconfdir}/systemd/system/multi-user.target.wants
	install -m 0644 ${WORKDIR}/variscite-ot.service ${D}/${systemd_unitdir}/system

	ln -sf ${systemd_unitdir}/system/variscite-ot.service \
		${D}${sysconfdir}/systemd/system/multi-user.target.wants/variscite-ot.service
}
