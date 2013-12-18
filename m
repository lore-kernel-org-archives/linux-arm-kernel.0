From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 18 Dec 2013 15:50:08 +0100
Subject: [PATCH 2/2] ARM: dts: tps65910 backup battery regulator
In-Reply-To: <1387378208-26841-1-git-send-email-mpa@pengutronix.de>
References: <1387378208-26841-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1387378208-26841-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a devicetree node for the backup battery regulator.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/tps65910.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/tps65910.dtsi b/arch/arm/boot/dts/tps65910.dtsi
index 92693a8..b0ac665 100644
--- a/arch/arm/boot/dts/tps65910.dtsi
+++ b/arch/arm/boot/dts/tps65910.dtsi
@@ -82,5 +82,10 @@
 			reg = <12>;
 			regulator-compatible = "vmmc";
 		};
+
+		vbb_reg: regulator at 13 {
+			reg = <13>;
+			regulator-compatible = "vbb";
+		};
 	};
 };
-- 
1.8.5.1
