From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Fri,  9 Jun 2017 14:57:30 +0200
Subject: [PATCH v5 3/3] ARM: dts: imx6qdl.dtsi: add "fsl,
 imx6q-snvs-lpgpr" node
In-Reply-To: <20170609125730.25502-1-o.rempel@pengutronix.de>
References: <20170609125730.25502-1-o.rempel@pengutronix.de>
Message-ID: <20170609125730.25502-4-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This node is for Low Power General Purpose Register which can
be used as Non-Volatile Storage.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index e426faa9c243..94e992558238 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -769,6 +769,10 @@
 					mask = <0x60>;
 					status = "disabled";
 				};
+
+				snvs_lpgpr: snvs-lpgpr {
+					compatible = "fsl,imx6q-snvs-lpgpr";
+				};
 			};
 
 			epit1: epit at 020d0000 { /* EPIT1 */
-- 
2.11.0
