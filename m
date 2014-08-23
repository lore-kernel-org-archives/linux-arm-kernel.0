From: horms+renesas@verge.net.au (Simon Horman)
Date: Sat, 23 Aug 2014 10:44:12 +0900
Subject: [PATCH 7/8] ARM: shmobile: marzen_defconfig: Enable missing hardware
 support
In-Reply-To: <cover.1408670623.git.horms+renesas@verge.net.au>
References: <cover.1408670623.git.horms+renesas@verge.net.au>
Message-ID: <6e3a4b191ee6db512c17197130b4e5170b3dabc3.1408670623.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Based on the DTS

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/marzen_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/marzen_defconfig b/arch/arm/configs/marzen_defconfig
index 92994f7..ff91630 100644
--- a/arch/arm/configs/marzen_defconfig
+++ b/arch/arm/configs/marzen_defconfig
@@ -84,6 +84,7 @@ CONFIG_GPIO_RCAR=y
 CONFIG_THERMAL=y
 CONFIG_RCAR_THERMAL=y
 CONFIG_SSB=y
+CONFIG_REGULATOR=y
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_V4L_PLATFORM_DRIVERS=y
-- 
2.0.1
