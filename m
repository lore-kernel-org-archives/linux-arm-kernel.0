From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 12 Nov 2018 13:31:14 +0100
Subject: [PATCH 2/3 v6] ARM: defconfig: Update the vexpress defconfig
In-Reply-To: <20181112123115.6176-1-linus.walleij@linaro.org>
References: <20181112123115.6176-1-linus.walleij@linaro.org>
Message-ID: <20181112123115.6176-3-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the Versatile Express defconfig to match the
Kconfig changes in the kernel.

Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v5->v6:
- Resending
ChangeLog v4->v5:
- Resending
ChangeLog v3->v4:
- Resending
ChangeLog v1->v3:
- Rebased
---
 arch/arm/configs/vexpress_defconfig | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/configs/vexpress_defconfig b/arch/arm/configs/vexpress_defconfig
index edae1c58fe80..226fe4bfb487 100644
--- a/arch/arm/configs/vexpress_defconfig
+++ b/arch/arm/configs/vexpress_defconfig
@@ -21,20 +21,17 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_ARCH_VEXPRESS=y
 CONFIG_ARCH_VEXPRESS_DCSCB=y
 CONFIG_ARCH_VEXPRESS_TC2_PM=y
-# CONFIG_SWP_EMULATE is not set
 CONFIG_SMP=y
 CONFIG_HAVE_ARM_ARCH_TIMER=y
 CONFIG_MCPM=y
 CONFIG_VMSPLIT_2G=y
 CONFIG_NR_CPUS=8
 CONFIG_ARM_PSCI=y
-CONFIG_AEABI=y
 CONFIG_CMA=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="console=ttyAMA0"
 CONFIG_CPU_IDLE=y
-CONFIG_CPU_IDLE_MULTIPLE_DRIVERS=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
@@ -61,7 +58,6 @@ CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_PLATRAM=y
 CONFIG_MTD_UBI=y
-CONFIG_PROC_DEVICETREE=y
 CONFIG_VIRTIO_BLK=y
 # CONFIG_SCSI_PROC_FS is not set
 CONFIG_BLK_DEV_SD=y
@@ -85,7 +81,6 @@ CONFIG_HW_RANDOM_VIRTIO=y
 CONFIG_I2C=y
 CONFIG_I2C_VERSATILE=y
 CONFIG_SENSORS_VEXPRESS=y
-CONFIG_REGULATOR=y
 CONFIG_REGULATOR_VEXPRESS=y
 CONFIG_FB=y
 CONFIG_FB_ARMCLCD=y
@@ -95,8 +90,6 @@ CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_VGA16 is not set
 CONFIG_SOUND=y
 CONFIG_SND=y
-CONFIG_SND_MIXER_OSS=y
-CONFIG_SND_PCM_OSS=y
 # CONFIG_SND_DRIVERS is not set
 CONFIG_SND_ARMAACI=y
 CONFIG_HID_DRAGONRISE=y
@@ -133,9 +126,6 @@ CONFIG_VIRTIO_MMIO=y
 CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-# CONFIG_EXT3_FS_XATTR is not set
-CONFIG_EXT4_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
@@ -149,11 +139,9 @@ CONFIG_9P_FS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_DEBUG_INFO=y
-CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_DEBUG_USER=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
-- 
2.17.2
