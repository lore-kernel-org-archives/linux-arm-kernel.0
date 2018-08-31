From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 31 Aug 2018 11:16:17 +0200
Subject: [PATCH 1/2] ARM: shmobile: defconfig: Enable VIDEO_RENESAS_FDP1
In-Reply-To: <20180831091618.6616-1-geert+renesas@glider.be>
References: <20180831091618.6616-1-geert+renesas@glider.be>
Message-ID: <20180831091618.6616-2-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

R-Car Gen2 (and RZ/G1) SoCs have a Fine Display Processor, hence enable
support for it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 7b48ec3e63ec3234..f2b40075819f4a0b 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -130,6 +130,7 @@ CONFIG_VIDEO_V4L2_SUBDEV_API=y
 CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_VIDEO_RCAR_VIN=y
 CONFIG_V4L_MEM2MEM_DRIVERS=y
+CONFIG_VIDEO_RENESAS_FDP1=y
 CONFIG_VIDEO_RENESAS_JPU=y
 CONFIG_VIDEO_RENESAS_VSP1=y
 # CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
-- 
2.17.1
