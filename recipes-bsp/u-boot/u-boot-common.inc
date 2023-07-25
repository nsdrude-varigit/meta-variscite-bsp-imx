LICENSE = "GPL-2.0-or-later"
LIC_FILES_CHKSUM = "file://Licenses/gpl-2.0.txt;md5=b234ee4d69f5fce4486a80fdaf4a4263"

DEPENDS += "bison-native"

UBOOT_SRC ?= "git://github.com/nsdrude-varigit/uboot-imx;protocol=https"

SRCBRANCH = "lf_v2022.04_var03-RND-1510-v2"
SRCREV = "5e2e72c814c3a0d75bf7a50ac59d3e5476c118dc"
UBOOT_INITIAL_ENV_DEVICE = "sd"

SRC_URI = "${UBOOT_SRC};branch=${SRCBRANCH}"

S = "${WORKDIR}/git"
