From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 27 Sep 2010 15:50:43 +0200
Subject: [PATCH 07/40] ARM: remove mx31pdk_defconfig
In-Reply-To: <20100927135009.GC6271@pengutronix.de>
References: <20100927135009.GC6271@pengutronix.de>
Message-ID: <1285595476-10025-7-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This machine is enabled in mx3_defconfig and so mx31pdk_defconfig isn't
really useful.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/configs/mx31pdk_defconfig |   44 ------------------------------------
 1 files changed, 0 insertions(+), 44 deletions(-)
 delete mode 100644 arch/arm/configs/mx31pdk_defconfig

diff --git a/arch/arm/configs/mx31pdk_defconfig b/arch/arm/configs/mx31pdk_defconfig
deleted file mode 100644
index 2d29329..0000000
--- a/arch/arm/configs/mx31pdk_defconfig
+++ /dev/null
@@ -1,44 +0,0 @@
-# CONFIG_LOCALVERSION_AUTO is not set
-# CONFIG_SWAP is not set
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
-# CONFIG_COMPAT_BRK is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_MXC=y
-# CONFIG_MACH_MX31ADS is not set
-CONFIG_MACH_MX31_3DS=y
-CONFIG_AEABI=y
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_NET_KEY=y
-CONFIG_INET=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-# CONFIG_INET_LRO is not set
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-# CONFIG_PREVENT_FIRMWARE_BUILD is not set
-# CONFIG_FIRMWARE_IN_KERNEL is not set
-# CONFIG_BLK_DEV is not set
-# CONFIG_MISC_DEVICES is not set
-CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO is not set
-# CONFIG_DEVKMEM is not set
-CONFIG_SERIAL_IMX=y
-CONFIG_SERIAL_IMX_CONSOLE=y
-# CONFIG_LEGACY_PTYS is not set
-# CONFIG_HW_RANDOM is not set
-# CONFIG_HWMON is not set
-# CONFIG_VGA_CONSOLE is not set
-# CONFIG_HID_SUPPORT is not set
-# CONFIG_USB_SUPPORT is not set
-# CONFIG_DNOTIFY is not set
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
-# CONFIG_ENABLE_MUST_CHECK is not set
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
-# CONFIG_CRC32 is not set
-- 
1.7.2.3
