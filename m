From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Tue,  4 Jun 2013 13:07:08 +0200
Subject: [PATCH 1/8] ARM i.MX53: mba53: enable usbotg & usbh1
In-Reply-To: <1370344035-7417-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1370344035-7417-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1370344035-7417-2-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michael Olbrich <m.olbrich@pengutronix.de>

Signed-off-by: Michael Olbrich <m.olbrich@pengutronix.de>
Signed-off-by: Markus Niebel <Markus.Niebel@tqs.de>
Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/imx53-mba53.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx53-mba53.dts b/arch/arm/boot/dts/imx53-mba53.dts
index 445a011..1420fe5 100644
--- a/arch/arm/boot/dts/imx53-mba53.dts
+++ b/arch/arm/boot/dts/imx53-mba53.dts
@@ -114,6 +114,15 @@
 	status = "okay";
 };
 
+&usbotg {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usbh1 {
+	status = "okay";
+};
+
 &uart1 {
 	status = "okay";
 };
-- 
1.8.2.rc2
