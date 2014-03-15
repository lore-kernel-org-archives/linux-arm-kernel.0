From: carlo@caione.org (Carlo Caione)
Date: Sat, 15 Mar 2014 16:43:45 +0100
Subject: [PATCH v2 8/8] ARM: sunxi: Add AXP20x support in defconfig
In-Reply-To: <1394898225-28452-1-git-send-email-carlo@caione.org>
References: <1394898225-28452-1-git-send-email-carlo@caione.org>
Message-ID: <1394898225-28452-9-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 arch/arm/configs/sunxi_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 3e2259b..0cef101 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -39,6 +39,8 @@ CONFIG_SUN4I_EMAC=y
 # CONFIG_NET_VENDOR_STMICRO is not set
 # CONFIG_NET_VENDOR_WIZNET is not set
 # CONFIG_WLAN is not set
+CONFIG_INPUT_MISC=y
+CONFIG_INPUT_AXP20X_PEK=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=8
@@ -52,6 +54,7 @@ CONFIG_GPIO_SYSFS=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
 CONFIG_SUNXI_WATCHDOG=y
+CONFIG_MFD_AXP20X=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
@@ -66,3 +69,4 @@ CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS=y
 CONFIG_PRINTK_TIME=y
+CONFIG_REGULATOR_AXP20X=y
-- 
1.8.3.2
