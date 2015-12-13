From: uri.mashiach@compulab.co.il (Uri Mashiach)
Date: Sun, 13 Dec 2015 10:55:35 +0200
Subject: [PATCH 1/5] ARM: dts: cm-t335: add support for USB0
In-Reply-To: <1449996939-13901-1-git-send-email-uri.mashiach@compulab.co.il>
References: <1445948100-16446-1-git-send-email-uri.mashiach@compulab.co.il>
 <1449996939-13901-1-git-send-email-uri.mashiach@compulab.co.il>
Message-ID: <1449996939-13901-2-git-send-email-uri.mashiach@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ilya Ledvich <ilya@compulab.co.il>

Enable USB0.

Signed-off-by: Ilya Ledvich <ilya@compulab.co.il>
Signed-off-by: Uri Mashiach <uri.mashiach@compulab.co.il>
Acked-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/boot/dts/am335x-cm-t335.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-cm-t335.dts b/arch/arm/boot/dts/am335x-cm-t335.dts
index 31ff1aa..ae2366e 100644
--- a/arch/arm/boot/dts/am335x-cm-t335.dts
+++ b/arch/arm/boot/dts/am335x-cm-t335.dts
@@ -237,6 +237,26 @@
 	};
 };
 
+&usb {
+	status = "okay";
+};
+
+&usb_ctrl_mod {
+	status = "okay";
+};
+
+&usb0_phy {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+};
+
+&cppi41dma  {
+	status = "okay";
+};
+
 &epwmss0 {
 	status = "okay";
 
-- 
2.5.0
