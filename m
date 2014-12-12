From: l.stelmach@samsung.com (=?UTF-8?q?=C5=81ukasz=20Stelmach?=)
Date: Fri, 12 Dec 2014 12:31:17 +0100
Subject: [PATCH] ARM: vexpress_defconfig: enable ACL and security labels for
 ext4
Message-ID: <1418383877-29685-1-git-send-email-l.stelmach@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables security features of ext4 file-system required
by many conteporary user-space setups.

Signed-off-by: ?ukasz Stelmach <l.stelmach@samsung.com>
---
 arch/arm/configs/vexpress_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/vexpress_defconfig b/arch/arm/configs/vexpress_defconfig
index f489fda..1d9dd6e 100644
--- a/arch/arm/configs/vexpress_defconfig
+++ b/arch/arm/configs/vexpress_defconfig
@@ -138,6 +138,8 @@ CONFIG_EXT3_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 # CONFIG_EXT3_FS_XATTR is not set
 CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
-- 
1.9.1
