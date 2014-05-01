From: carlo@caione.org (Carlo Caione)
Date: Thu,  1 May 2014 14:29:32 +0200
Subject: [PATCH v5 6/8] ARM: sunxi: Add AXP20x support in defconfig
In-Reply-To: <1398947374-3115-1-git-send-email-carlo@caione.org>
References: <1398947374-3115-1-git-send-email-carlo@caione.org>
Message-ID: <1398947374-3115-7-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 arch/arm/configs/sunxi_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index b5df4a5..6e305da 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -40,6 +40,8 @@ CONFIG_SUN4I_EMAC=y
 # CONFIG_NET_VENDOR_STMICRO is not set
 # CONFIG_NET_VENDOR_WIZNET is not set
 # CONFIG_WLAN is not set
+CONFIG_INPUT_MISC=y
+CONFIG_INPUT_AXP20X_PEK=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=8
@@ -55,6 +57,7 @@ CONFIG_GPIO_SYSFS=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
 CONFIG_SUNXI_WATCHDOG=y
+CONFIG_MFD_AXP20X=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
@@ -69,3 +72,4 @@ CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS=y
 CONFIG_PRINTK_TIME=y
+CONFIG_REGULATOR_AXP20X=y
-- 
1.8.3.2
