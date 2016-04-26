From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 26 Apr 2016 18:15:45 +0200
Subject: [PATCH 2/4] ARM: multi_v7_defconfig: add Atmel ISI (Image Sensor
 Interface) driver
In-Reply-To: <c1ec7d16df28a0f9d72c1106f21f1f013a0011c1.1461687187.git.nicolas.ferre@atmel.com>
References: <c1ec7d16df28a0f9d72c1106f21f1f013a0011c1.1461687187.git.nicolas.ferre@atmel.com>
Message-ID: <8002556ddfc868a61b958fac52919d73ec9b6698.1461687187.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the Atmel Image Sensor Interface (ISI) VIDEO driver as a module.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index d72ee27cecae..901eaf55c5a7 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -517,6 +517,7 @@ CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_SOC_CAMERA=m
 CONFIG_SOC_CAMERA_PLATFORM=m
 CONFIG_VIDEO_RCAR_VIN=m
+CONFIG_VIDEO_ATMEL_ISI=m
 CONFIG_V4L_MEM2MEM_DRIVERS=y
 CONFIG_VIDEO_RENESAS_JPU=m
 CONFIG_VIDEO_RENESAS_VSP1=m
-- 
2.1.3
