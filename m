From: tobetter@gmail.com (Dongjin Kim)
Date: Tue,  5 Feb 2013 09:56:16 +0900
Subject: [PATCH] ARM: dts: Fix the timing property of MSHC controller
In-Reply-To: <1358959242-1667-1-git-send-email-tobetter@gmail.com>
References: <1358959242-1667-1-git-send-email-tobetter@gmail.com>
Message-ID: <1360025780-17158-1-git-send-email-tobetter@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the property of dw-mshc-sdr-timing and dw-mshc-ddr-timing as per
its current binding, it only has two cells.

Signed-off-by: Dongjin Kim <tobetter@gmail.com>
---
 arch/arm/boot/dts/exynos4412-odroidx.dts |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
index f41a84e..009a9c2 100644
--- a/arch/arm/boot/dts/exynos4412-odroidx.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
@@ -49,8 +49,8 @@
 		fifo-depth = <0x80>;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
-		samsung,dw-mshc-sdr-timing = <2 3 3>;
-		samsung,dw-mshc-ddr-timing = <1 2 3>;
+		samsung,dw-mshc-sdr-timing = <2 3>;
+		samsung,dw-mshc-ddr-timing = <1 2>;
 
 		slot at 0 {
 			reg = <0>;
-- 
1.7.10.4
