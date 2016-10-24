From: david@lechnology.com (David Lechner)
Date: Mon, 24 Oct 2016 17:48:18 -0500
Subject: [PATCH] ARM: davinci: Enable PHY_DA8XX_USB by default
Message-ID: <1477349298-10315-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the DA8xx USB PHY driver by default. This driver used by several
davinci family devices.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/configs/davinci_all_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index a5fca37..c58ae1c 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -187,6 +187,7 @@ CONFIG_DMADEVICES=y
 CONFIG_TI_EDMA=y
 CONFIG_MEMORY=y
 CONFIG_TI_AEMIF=m
+CONFIG_PHY_DA8XX_USB=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_XFS_FS=m
-- 
2.7.4
