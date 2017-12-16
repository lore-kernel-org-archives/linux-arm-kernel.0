From: embed3d@gmail.com (Philipp Rossak)
Date: Sat, 16 Dec 2017 03:49:12 +0100
Subject: [RFC 3/5] ARM: dts: sun8i: a83t: Add the ir pin for the A83T
In-Reply-To: <20171216024914.7550-1-embed3d@gmail.com>
References: <20171216024914.7550-1-embed3d@gmail.com>
Message-ID: <20171216024914.7550-4-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CIR Pin of the A83T is located at PL12

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 19acae1b4089..5edb645b506f 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -488,6 +488,11 @@
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
