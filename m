From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 14 Apr 2014 17:37:27 +0200
Subject: [PATCH 05/10] ARM: dts: pbab01: Set linux,stdout-path to UART4
In-Reply-To: <1397489852-1669-1-git-send-email-p.zabel@pengutronix.de>
References: <1397489852-1669-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1397489852-1669-5-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
index cd2d4af..4e36aef 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
@@ -9,6 +9,12 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
+/ {
+	chosen {
+		linux,stdout-path = &uart4;
+	};
+};
+
 &fec {
 	status = "okay";
 };
-- 
1.9.1
