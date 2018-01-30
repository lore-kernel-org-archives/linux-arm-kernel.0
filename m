From: embed3d@gmail.com (Philipp Rossak)
Date: Tue, 30 Jan 2018 18:46:53 +0100
Subject: [PATCH v5 3/6] arm: dts: sun8i: a83t: Add the cir pin for the A83T
In-Reply-To: <20180130174656.10657-1-embed3d@gmail.com>
References: <20180130174656.10657-1-embed3d@gmail.com>
Message-ID: <20180130174656.10657-4-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CIR Pin of the A83T is located at PL12.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 7f4955a5fab7..f7f78a27e21d 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -716,6 +716,11 @@
 			interrupt-controller;
 			#interrupt-cells = <3>;
 
+			r_cir_pin: r-cir-pin {
+				pins = "PL12";
+				function = "s_cir_rx";
+			};
+
 			r_rsb_pins: r-rsb-pins {
 				pins = "PL0", "PL1";
 				function = "s_rsb";
-- 
2.11.0
