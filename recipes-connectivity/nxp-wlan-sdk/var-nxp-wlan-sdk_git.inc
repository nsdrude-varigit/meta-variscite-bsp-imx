LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"

# For Kernel 5.4 and later
SRCBRANCH = "lf-5.15.71_2.2.0"
MRVL_SRC = "git://github.com/varigit/mwifiex-iw612.git;protocol=https"
SRC_URI = "${MRVL_SRC};branch=${SRCBRANCH}"
SRCREV = "4ab3759b13e9e85508ea0c786ec66693c21dfbcd"

S = "${WORKDIR}/git"
