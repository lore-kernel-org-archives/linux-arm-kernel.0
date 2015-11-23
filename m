From: monnier@iro.umontreal.ca (Stefan Monnier)
Date: Mon, 23 Nov 2015 13:50:16 -0500
Subject: [PATCH 1/2] ARM: dts: sun7i: Enable audio codec on OrangePi Mini
Message-ID: <1448304618-3488-1-git-send-email-monnier@iro.umontreal.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the on-chip audio codec

Signed-off-by: Stefan Monnier <monnier@iro.umontreal.ca>
---
 arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts b/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
index 4f65664..2be04c43 100644
--- a/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
+++ b/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
@@ -95,6 +95,10 @@
 	status = "okay";
 };
 
+&codec {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
-- 
2.1.4
