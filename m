From: embed3d@gmail.com (Philipp Rossak)
Date: Sun, 17 Dec 2017 23:45:45 +0100
Subject: [PATCH 3/5] arm: dts: sun8i: a83t: Add the ir pin for the A83T
In-Reply-To: <20171217224547.21481-1-embed3d@gmail.com>
References: <20171217224547.21481-1-embed3d@gmail.com>
Message-ID: <20171217224547.21481-4-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CIR Pin of the A83T is located at PL12.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index a384b766f3dc..954c2393325f 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -521,6 +521,11 @@
 				drive-strength = <20>;
 				bias-pull-up;
 			};
+
+			ir_pins_a: ir at 0 {
+				pins = "PL12";
+				function = "s_cir_rx";
+			};
 		};
 
 		r_rsb: rsb at 1f03400 {
-- 
2.11.0
