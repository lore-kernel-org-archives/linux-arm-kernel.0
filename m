From: thor.thayer@linux.intel.com (thor.thayer at linux.intel.com)
Date: Wed, 27 Jun 2018 12:50:27 -0500
Subject: [PATCH] arm64: dts: stratix10: Add SPI node clocks for Stratix10
Message-ID: <1530121827-32390-1-git-send-email-thor.thayer@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add the required clocks for the new Stratix10 clock bindings
to the SPI nodes.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 67dac595dc72..9e54282ee08c 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -310,6 +310,7 @@
 			resets = <&rst SPIM0_RESET>;
 			reg-io-width = <4>;
 			num-cs = <4>;
+			clocks = <&clkmgr STRATIX10_L4_MAIN_CLK>;
 			status = "disabled";
 		};
 
@@ -322,6 +323,7 @@
 			resets = <&rst SPIM1_RESET>;
 			reg-io-width = <4>;
 			num-cs = <4>;
+			clocks = <&clkmgr STRATIX10_L4_MAIN_CLK>;
 			status = "disabled";
 		};
 
-- 
2.7.4
