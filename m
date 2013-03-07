From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  7 Mar 2013 23:14:16 +0100
Subject: [PATCH 2/6] ARM: sunxi: dt: Use clocks property instead of
 clock-frequency for the UARTs
In-Reply-To: <1362694460-1919-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1362694460-1919-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1362694460-1919-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It will be especially useful when we will have the clock definitions in
the device tree.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sunxi.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sunxi.dtsi b/arch/arm/boot/dts/sunxi.dtsi
index 8b36abe..791c02a 100644
--- a/arch/arm/boot/dts/sunxi.dtsi
+++ b/arch/arm/boot/dts/sunxi.dtsi
@@ -65,7 +65,7 @@
 			interrupts = <1>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clock-frequency = <24000000>;
+			clocks = <&osc>;
 			status = "disabled";
 		};
 
@@ -75,7 +75,7 @@
 			interrupts = <2>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clock-frequency = <24000000>;
+			clocks = <&osc>;
 			status = "disabled";
 		};
 	};
-- 
1.7.10.4
