From: hongbo.zhang@linaro.org (Hongbo Zhang)
Date: Wed, 30 Jan 2013 17:21:40 +0800
Subject: [PATCH] ARM: ux500: enable ux500 EXT4_FS and LBDAF support by default
Message-ID: <1359537700-19293-1-git-send-email-hongbo.zhang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

EXT4 file system and LBDAF are used commonly, should be enabled by default.

Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
---
 arch/arm/configs/u8500_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index 231dca6..746c8a2 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -5,7 +5,6 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-# CONFIG_LBDAF is not set
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_ARCH_U8500=y
 CONFIG_MACH_HREFV60=y
@@ -103,6 +102,7 @@ CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
 CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
-- 
1.8.0
