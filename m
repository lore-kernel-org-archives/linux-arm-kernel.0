From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Fri, 25 Mar 2011 09:29:00 -0600
Subject: [PATCH 7/8] ux500: adding config file options for snowball board.
In-Reply-To: <1301066941-15877-1-git-send-email-mathieu.poirier@linaro.org>
References: <1301066941-15877-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1301066941-15877-8-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu J. Poirier <mathieu.poirier@linaro.org>

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 arch/arm/configs/u8500_defconfig |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index e1d6020..80e26b2 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -11,6 +11,7 @@ CONFIG_ARCH_U8500=y
 CONFIG_UX500_SOC_DB5500=y
 CONFIG_UX500_SOC_DB8500=y
 CONFIG_MACH_U8500=y
+CONFIG_MACH_U8500_SNOWBALL=y
 CONFIG_MACH_U5500=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
@@ -25,6 +26,13 @@ CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+# CONFIG_IPV6 is not set
+CONFIG_NETFILTER=y
 CONFIG_PHONET=y
 CONFIG_PHONET_PIPECTRLR=y
 # CONFIG_WIRELESS is not set
@@ -35,6 +43,13 @@ CONFIG_BLK_DEV_RAM_SIZE=65536
 CONFIG_MISC_DEVICES=y
 CONFIG_AB8500_PWM=y
 CONFIG_SENSORS_BH1780=y
+CONFIG_NETDEVICES=y
+CONFIG_SMSC_PHY=y
+CONFIG_NET_ETHERNET=y
+CONFIG_SMSC911X=y
+# CONFIG_NETDEV_1000 is not set
+# CONFIG_NETDEV_10000 is not set
+# CONFIG_WLAN is not set
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 CONFIG_INPUT_EVDEV=y
 # CONFIG_KEYBOARD_ATKBD is not set
@@ -64,7 +79,6 @@ CONFIG_GPIO_TC3589X=y
 CONFIG_MFD_STMPE=y
 CONFIG_MFD_TC3589X=y
 CONFIG_AB8500_CORE=y
-CONFIG_REGULATOR=y
 CONFIG_REGULATOR_AB8500=y
 # CONFIG_HID_SUPPORT is not set
 CONFIG_USB_MUSB_HDRC=y
@@ -95,6 +109,8 @@ CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_CONFIGFS_FS=m
 # CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_NFS_FS=y
+CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_MAGIC_SYSRQ=y
-- 
1.7.1
