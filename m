From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 15 May 2012 10:54:43 +0200
Subject: [PATCH 7/8] arm: mach-armada: add defconfig
In-Reply-To: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1337072084-21967-8-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Lior Amsalem <alior@marvell.com>
---
 arch/arm/configs/armada_defconfig |   47 +++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 arch/arm/configs/armada_defconfig

diff --git a/arch/arm/configs/armada_defconfig b/arch/arm/configs/armada_defconfig
new file mode 100644
index 0000000..3ead861
--- /dev/null
+++ b/arch/arm/configs/armada_defconfig
@@ -0,0 +1,47 @@
+CONFIG_EXPERIMENTAL=y
+CONFIG_SYSVIPC=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_EXPERT=y
+CONFIG_SLAB=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_ARCH_ARMADA=y
+CONFIG_MACH_ARMADA_370_DT=y
+CONFIG_MACH_ARMADA_XP_DT=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_AEABI=y
+CONFIG_USE_OF=y
+CONFIG_ZBOOT_ROM_TEXT=0x0
+CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_ARM_APPENDED_DTB=y
+CONFIG_VFP=y
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_RUNTIME_UARTS=2
+CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_EXT2_FS=y
+CONFIG_EXT3_FS=y
+# CONFIG_EXT3_FS_XATTR is not set
+CONFIG_ISO9660_FS=y
+CONFIG_JOLIET=y
+CONFIG_UDF_FS=m
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_TMPFS=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_CODEPAGE_850=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_NLS_ISO8859_2=y
+CONFIG_NLS_UTF8=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_FS=y
+# CONFIG_SCHED_DEBUG is not set
+CONFIG_TIMER_STATS=y
+# CONFIG_DEBUG_BUGVERBOSE is not set
+CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_USER=y
+CONFIG_DEBUG_LL=y
+CONFIG_EARLY_PRINTK=y
-- 
1.7.9.5
