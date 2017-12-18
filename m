From: embed3d@gmail.com (Philipp Rossak)
Date: Mon, 18 Dec 2017 15:11:43 +0100
Subject: [PATCH v2 3/6] arm: dts: sun8i: a83t: Add the cir pin for the A83T
In-Reply-To: <20171218141146.23746-1-embed3d@gmail.com>
References: <20171218141146.23746-1-embed3d@gmail.com>
Message-ID: <20171218141146.23746-4-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CIR Pin of the A83T is located at PL12.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index de5119a2a91c..feffca8a9a24 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -623,6 +623,11 @@
 				drive-strength = <20>;
 				bias-pull-up;
 			};
+
+			cir_pins: cir-pins at 0 {
+				pins = "PL12";
+				function = "s_cir_rx";
+			};
 		};
 
 		r_rsb: rsb at 1f03400 {
-- 
2.11.0
