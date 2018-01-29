From: embed3d@gmail.com (Philipp Rossak)
Date: Mon, 29 Jan 2018 16:58:07 +0100
Subject: [PATCH v4 3/6] arm: dts: sun8i: a83t: Add the cir pin for the A83T
In-Reply-To: <20180129155810.7867-1-embed3d@gmail.com>
References: <20180129155810.7867-1-embed3d@gmail.com>
Message-ID: <20180129155810.7867-4-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CIR Pin of the A83T is located at PL12.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index de5119a2a91c..06e96db7c41a 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -617,6 +617,11 @@
 			interrupt-controller;
 			#interrupt-cells = <3>;
 
+			cir_pins: cir-pins at 0 {
+				pins = "PL12";
+				function = "s_cir_rx";
+			};
+
 			r_rsb_pins: r-rsb-pins {
 				pins = "PL0", "PL1";
 				function = "s_rsb";
-- 
2.11.0
