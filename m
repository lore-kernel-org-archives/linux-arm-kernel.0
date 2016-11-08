From: dinguyen@kernel.org (Dinh Nguyen)
Date: Tue,  8 Nov 2016 16:47:50 -0600
Subject: [PATCH] ARM: socfpga_defconfig: enable FS configs to support Angstrom
 filesystem
Message-ID: <20161108224750.30242-1-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enables:

CONFIG_AUTOFS4_FS=y
CONFIG_NFSD=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y

Signed-off-by: Matthew Gerlach <mgerlach@opensource.altera.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm/configs/socfpga_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 18d3ec1..2e1d254 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -116,13 +116,18 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT3_FS=y
+CONFIG_AUTOFS4_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_NTFS_FS=y
 CONFIG_NTFS_RW=y
 CONFIG_TMPFS=y
 CONFIG_CONFIGFS_FS=y
 CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
 CONFIG_ROOT_NFS=y
+CONFIG_NFSD=y
+CONFIG_NFSD_V3_ACL=y
+CONFIG_NFSD_V4=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
-- 
2.8.3
