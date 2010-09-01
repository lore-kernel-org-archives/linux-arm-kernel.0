From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed,  1 Sep 2010 16:09:20 +0900
Subject: [PATCH 13/13] ARM: s5p64x0_defconfig: Update for support S5P6440 and
	S5P6450
In-Reply-To: <1283324960-21629-1-git-send-email-kgene.kim@samsung.com>
References: <1283324960-21629-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1283324960-21629-14-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates s5p64x0_defconfig and changes the name from
s5p6440_defconfig so that can support S5P6440 and S5P6450 with
one kernel.

Tested on SMDK6440(S5P6440) and SMDK6450(S5P6450).

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 .../{s5p6440_defconfig => s5p64x0_defconfig}       |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)
 rename arch/arm/configs/{s5p6440_defconfig => s5p64x0_defconfig} (97%)

diff --git a/arch/arm/configs/s5p6440_defconfig b/arch/arm/configs/s5p64x0_defconfig
similarity index 97%
rename from arch/arm/configs/s5p6440_defconfig
rename to arch/arm/configs/s5p64x0_defconfig
index 0b0266c..2993ecd 100644
--- a/arch/arm/configs/s5p6440_defconfig
+++ b/arch/arm/configs/s5p64x0_defconfig
@@ -5,10 +5,11 @@ CONFIG_KALLSYMS_ALL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_S5P6440=y
+CONFIG_ARCH_S5P64X0=y
 CONFIG_S3C_BOOT_ERROR_RESET=y
 CONFIG_S3C_LOWLEVEL_UART_PORT=1
 CONFIG_MACH_SMDK6440=y
+CONFIG_MACH_SMDK6450=y
 CONFIG_CPU_32v6K=y
 CONFIG_AEABI=y
 CONFIG_CMDLINE="root=/dev/ram0 rw ramdisk=8192 initrd=0x20800000,8M console=ttySAC1,115200 init=/linuxrc"
-- 
1.6.2.5
