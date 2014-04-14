From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 14 Apr 2014 17:37:31 +0200
Subject: [PATCH 09/10] ARM: dts: pbab01: Enable UART1
In-Reply-To: <1397489852-1669-1-git-send-email-p.zabel@pengutronix.de>
References: <1397489852-1669-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1397489852-1669-9-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables UART1 on the phyFLEX connector (i.MX6 uart3).

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
index c6ab762..323a647 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
@@ -57,6 +57,10 @@
 	status = "okay";
 };
 
+&uart3 {
+	status = "okay";
+};
+
 &uart4 {
 	status = "okay";
 };
-- 
1.9.1
