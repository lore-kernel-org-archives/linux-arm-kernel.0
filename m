From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  3 Feb 2015 06:22:04 +0800
Subject: [PATCH v4 4/5] ARM: sunxi_defconfig: Enable CONFIG_PHY_SUN9I_USB
In-Reply-To: <1422915725-26492-1-git-send-email-wens@csie.org>
References: <1422915725-26492-1-git-send-email-wens@csie.org>
Message-ID: <1422915725-26492-5-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On sun9i we have a new PHY driver for USB.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/configs/sunxi_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 38840a812924..6b271645eb43 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -106,6 +106,7 @@ CONFIG_RTC_DRV_SUN6I=y
 CONFIG_RTC_DRV_SUNXI=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_PHY_SUN4I_USB=y
+CONFIG_PHY_SUN9I_USB=y
 CONFIG_EXT4_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
-- 
2.1.4
