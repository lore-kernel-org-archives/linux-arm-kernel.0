From: prakity@marvell.com (Philip Rakity)
Date: Tue, 15 Feb 2011 13:56:47 -0800
Subject: [PATCH 2/4] arm: V2 configs: update pxa168 defconfig for SoC
	Selection
Message-ID: <15EF0652-2088-4876-AF9D-CDAC8E423CA8@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

V2
==
Use make savedefconfigconfig to produce reduced size defconfig
per suggestion of Nico Pitre.

V1
took old pxa168_defconfig --
did make menuconfig

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 arch/arm/configs/pxa168_defconfig |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/configs/pxa168_defconfig b/arch/arm/configs/pxa168_defconfig
index 74d7e01..b07eb58 100644
--- a/arch/arm/configs/pxa168_defconfig
+++ b/arch/arm/configs/pxa168_defconfig
@@ -1,7 +1,6 @@
 CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_SLAB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
@@ -30,7 +29,6 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_STANDALONE is not set
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
 # CONFIG_BLK_DEV is not set
-# CONFIG_MISC_DEVICES is not set
 CONFIG_NETDEVICES=y
 CONFIG_NET_ETHERNET=y
 CONFIG_SMC91X=y
@@ -45,10 +43,8 @@ CONFIG_SERIAL_PXA_CONSOLE=y
 # CONFIG_LEGACY_PTYS is not set
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
-# CONFIG_VGA_CONSOLE is not set
 # CONFIG_HID_SUPPORT is not set
 # CONFIG_USB_SUPPORT is not set
-CONFIG_INOTIFY=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_CRAMFS=y
-- 
1.7.0.4
