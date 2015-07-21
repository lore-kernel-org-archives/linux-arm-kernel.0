From: rogershimizu@gmail.com (Roger Shimizu)
Date: Tue, 21 Jul 2015 23:49:17 +0900
Subject: [PATCH v2 2/2] ARM: defconfig: orion5x: add DT support
In-Reply-To: <1437490157-8194-1-git-send-email-rogershimizu@gmail.com>
References: <1437490157-8194-1-git-send-email-rogershimizu@gmail.com>
Message-ID: <1437490157-8194-3-git-send-email-rogershimizu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- add 2 DT device entries
- enable CONFIG_ARM_ATAG_DTB_COMPAT

Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
---
 arch/arm/configs/orion5x_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/orion5x_defconfig b/arch/arm/configs/orion5x_defconfig
index 855143f..8099417 100644
--- a/arch/arm/configs/orion5x_defconfig
+++ b/arch/arm/configs/orion5x_defconfig
@@ -14,8 +14,10 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_BSD_DISKLABEL=y
 CONFIG_ARCH_ORION5X=y
+CONFIG_ARCH_ORION5X_DT=y
 CONFIG_MACH_DB88F5281=y
 CONFIG_MACH_RD88F5182=y
+CONFIG_MACH_RD88F5182_DT=y
 CONFIG_MACH_KUROBOX_PRO=y
 CONFIG_MACH_DNS323=y
 CONFIG_MACH_TS209=y
@@ -41,6 +43,7 @@ CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
+CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_FPE_NWFPE=y
 CONFIG_VFP=y
 CONFIG_NET=y
-- 
1.9.1
