From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 05 Apr 2013 11:53:49 +0530
Subject: [PATCH 3/3] ARM: dts: add clock provider information for i2s0
 controller in Exynos5250
In-Reply-To: <1365143029-16936-1-git-send-email-padma.v@samsung.com>
References: <1365143029-16936-1-git-send-email-padma.v@samsung.com>
Message-ID: <1365143029-16936-3-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock lookup information for i2s0 controller on exynos5250 SoC.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/boot/dts/exynos5250.dtsi |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 14d454c..08e3b3f 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -387,6 +387,8 @@
 			&pdma0 9
 			&pdma0 8>;
 		dma-names = "tx", "rx", "tx-sec";
+		clocks = <&clock_audss 6>, <&clock_audss 6>, <&clock_audss 7>;
+		clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
 		samsung,supports-6ch;
 		samsung,supports-rstclr;
 		samsung,supports-secdai;
-- 
1.7.4.4
