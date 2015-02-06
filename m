From: festevam@gmail.com (Fabio Estevam)
Date: Fri,  6 Feb 2015 20:09:46 -0200
Subject: [PATCH 1/2] ARM: mxs_defconfig: Add VFAT support
Message-ID: <1423260587-3225-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Select CONFIG_VFAT_FS by default.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/mxs_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index c7906c2..b47e7c6 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -149,6 +149,7 @@ CONFIG_EXT4_FS=y
 CONFIG_FSCACHE=m
 CONFIG_FSCACHE_STATS=y
 CONFIG_CACHEFILES=m
+CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_JFFS2_FS=y
-- 
1.9.1
