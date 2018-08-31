From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 31 Aug 2018 11:16:18 +0200
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Enable VIDEO_RENESAS_FDP1
In-Reply-To: <20180831091618.6616-1-geert+renesas@glider.be>
References: <20180831091618.6616-1-geert+renesas@glider.be>
Message-ID: <20180831091618.6616-3-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

R-Car Gen2 (and RZ/G1) SoCs have a Fine Display Processor, hence enable
support for it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index a36c1b3111303563..983d8b7a410caba8 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -584,6 +584,7 @@ CONFIG_VIDEO_SAMSUNG_EXYNOS_GSC=m
 CONFIG_VIDEO_STI_BDISP=m
 CONFIG_VIDEO_STI_HVA=m
 CONFIG_VIDEO_STI_DELTA=m
+CONFIG_VIDEO_RENESAS_FDP1=m
 CONFIG_VIDEO_RENESAS_JPU=m
 CONFIG_VIDEO_RENESAS_VSP1=m
 CONFIG_V4L_TEST_DRIVERS=y
-- 
2.17.1
