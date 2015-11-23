From: monnier@iro.umontreal.ca (Stefan Monnier)
Date: Mon, 23 Nov 2015 13:50:17 -0500
Subject: [PATCH 2/2] ARM: dts: sun7i: Enable audio codec on BananaPi
In-Reply-To: <1448304618-3488-1-git-send-email-monnier@iro.umontreal.ca>
References: <1448304618-3488-1-git-send-email-monnier@iro.umontreal.ca>
Message-ID: <1448304618-3488-2-git-send-email-monnier@iro.umontreal.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the on-chip audio codec

Signed-off-by: Stefan Monnier <monnier@iro.umontreal.ca>
---
 arch/arm/boot/dts/sun7i-a20-bananapi.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
index fd7594f..67c8a76 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
@@ -92,6 +92,10 @@
 	status = "okay";
 };
 
+&codec {
+	status = "okay";
+};
+
 &cpu0 {
 	cpu-supply = <&reg_dcdc2>;
 	operating-points = <
-- 
2.1.4
