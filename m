From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 31 Jan 2012 16:48:30 +0800
Subject: [PATCH] ARM: imx: update imx_v6_v7_defconfig
Message-ID: <1327999710-29841-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds CONFIG_BLK_DEV_INITRD and runs savedefconfig.  The resulted
can boot Linaro rootfs out of box.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/configs/imx_v6_v7_defconfig |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 3a4fb2e..fa236a2 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -5,6 +5,7 @@ CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=18
 CONFIG_CGROUPS=y
 CONFIG_RELAY=y
+CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 # CONFIG_SLUB_DEBUG is not set
 # CONFIG_COMPAT_BRK is not set
@@ -12,7 +13,6 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
-# CONFIG_LBDAF is not set
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_ARCH_MXC=y
 CONFIG_MACH_MX31LILLY=y
@@ -26,7 +26,6 @@ CONFIG_MACH_ARMADILLO5X0=y
 CONFIG_MACH_KZM_ARM11_01=y
 CONFIG_MACH_PCM043=y
 CONFIG_MACH_MX35_3DS=y
-CONFIG_MACH_EUKREA_CPUIMX35=y
 CONFIG_MACH_VPR200=y
 CONFIG_MACH_IMX51_DT=y
 CONFIG_MACH_MX51_3DS=y
@@ -83,7 +82,6 @@ CONFIG_NETDEVICES=y
 # CONFIG_NET_VENDOR_BROADCOM is not set
 # CONFIG_NET_VENDOR_CHELSIO is not set
 # CONFIG_NET_VENDOR_FARADAY is not set
-CONFIG_FEC=y
 # CONFIG_NET_VENDOR_INTEL is not set
 # CONFIG_NET_VENDOR_MARVELL is not set
 # CONFIG_NET_VENDOR_MICREL is not set
-- 
1.7.5.4
