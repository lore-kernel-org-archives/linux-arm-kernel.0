From: festevam@gmail.com (Fabio Estevam)
Date: Fri,  6 Feb 2015 20:09:47 -0200
Subject: [PATCH 2/2] ARM: imx_v4_v5_defconfig: Add VFAT support
In-Reply-To: <1423260587-3225-1-git-send-email-festevam@gmail.com>
References: <1423260587-3225-1-git-send-email-festevam@gmail.com>
Message-ID: <1423260587-3225-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Select CONFIG_VFAT_FS by default.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v4_v5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index e6b0007..5a45d3e 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -177,6 +177,7 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT4_FS=y
 # CONFIG_DNOTIFY is not set
+CONFIG_VFAT_FS=y
 # CONFIG_PROC_PAGE_MONITOR is not set
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
-- 
1.9.1
