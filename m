From: olof@lixom.net (Olof Johansson)
Date: Mon, 20 Oct 2014 00:20:01 -0700
Subject: [PATCH] ARM: multi_v7_defconfig: enable CONFIG_MMC_DW_ROCKCHIP
Message-ID: <1413789601-18350-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allows booting from SD/MMC on RK3288 and other platforms. Added here so I
can enable the board in the boot farm.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 491b7d5523bf..709ecc9009ec 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -353,6 +353,7 @@ CONFIG_MMC_MVSDIO=y
 CONFIG_MMC_SUNXI=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_EXYNOS=y
+CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
-- 
2.0.1.473.gc4d58ca
