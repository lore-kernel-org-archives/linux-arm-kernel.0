From: olof@lixom.net (Olof Johansson)
Date: Sat, 17 Dec 2011 20:48:04 -0800
Subject: [PATCH] arm/tegra: refresh defconfig for tegra30
Message-ID: <1324183684-19606-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the defconfig for tegra due to the addition of tegra30 and rename
of t20/t30 options.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/configs/tegra_defconfig |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 1957297..fd5d304 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -9,9 +9,8 @@ CONFIG_RESOURCE_COUNTERS=y
 CONFIG_CGROUP_SCHED=y
 CONFIG_RT_GROUP_SCHED=y
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_EMBEDDED=y
-# CONFIG_SYSCTL_SYSCALL is not set
 # CONFIG_ELF_CORE is not set
+CONFIG_EMBEDDED=y
 CONFIG_SLAB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
@@ -20,6 +19,8 @@ CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
 CONFIG_ARCH_TEGRA=y
+CONFIG_ARCH_TEGRA_2x_SOC=y
+CONFIG_ARCH_TEGRA_3x_SOC=y
 CONFIG_MACH_HARMONY=y
 CONFIG_MACH_KAEN=y
 CONFIG_MACH_PAZ00=y
@@ -78,14 +79,12 @@ CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=y
-CONFIG_NET_ETHERNET=y
 CONFIG_R8169=y
-# CONFIG_NETDEV_10000 is not set
-# CONFIG_WLAN is not set
 CONFIG_USB_PEGASUS=y
 CONFIG_USB_USBNET=y
 CONFIG_USB_NET_SMSC75XX=y
 CONFIG_USB_NET_SMSC95XX=y
+# CONFIG_WLAN is not set
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
-- 
1.7.5.4
