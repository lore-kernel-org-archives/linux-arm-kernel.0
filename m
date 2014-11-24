From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 24 Nov 2014 19:57:50 +0900
Subject: [PATCHv3 3/3] ARM: dts: Remove unused command line from
 Exynos3250-based Rinato board
In-Reply-To: <1416826670-29438-1-git-send-email-cw00.choi@samsung.com>
References: <1416826670-29438-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1416826670-29438-4-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes unused dt node of command line from Exynos3250-based
Rinato board because kernel use the command line from bootloader.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 arch/arm/boot/dts/exynos3250-rinato.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index 84380fa..80aa8b4 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -28,10 +28,6 @@
 		reg =  <0x40000000 0x1ff00000>;
 	};
 
-	chosen {
-		bootargs = "console=ttySAC1,115200N8 root=/dev/mmcblk0p15 rootwait earlyprintk panic=5";
-	};
-
 	firmware at 0205F000 {
 		compatible = "samsung,secure-firmware";
 		reg = <0x0205F000 0x1000>;
-- 
1.8.5.5
