From: thor.thayer@linux.intel.com (thor.thayer at linux.intel.com)
Date: Thu,  5 Jul 2018 17:18:34 -0500
Subject: [v4.14-stable] arm64: dts: stratix10: Fix SPI IRQ for Stratix10
Message-ID: <1530829114-16889-1-git-send-email-thor.thayer@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Fix the SPI interrupt numbers for Stratix10.

This is a backport for stable 4.9.x and 4.14.x branches.
(original includes other changes that are not relevant
to this branch):

[backport 'commit 889d15090420 ("arm64: dts: stratix10:
    fix SPI settings")']

Cc: <stable@vger.kernel.org>  # 4.9.x
Cc: <stable@vger.kernel.org>  # 4.14.x
Fixes: 78cd6a9d8e154 ("arm64: dts: Add base stratix 10 dtsi")
Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 57f75453ee93..5db972c0492f 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -230,7 +230,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0xffda4000 0x1000>;
-			interrupts = <0 101 4>;
+			interrupts = <0 99 4>;
 			num-cs = <4>;
 			status = "disabled";
 		};
@@ -240,7 +240,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0xffda5000 0x1000>;
-			interrupts = <0 102 4>;
+			interrupts = <0 100 4>;
 			num-cs = <4>;
 			status = "disabled";
 		};
-- 
2.7.4
