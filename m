From: hdegoede@redhat.com (Hans de Goede)
Date: Tue,  3 Nov 2015 16:47:20 +0100
Subject: [PATCH] ARM: dts: sun7i: Enable audio codec on pcDuino
Message-ID: <1446565640-21069-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jelle van der Waa <jelle@vdwaa.nl>

Enable the on-chip audio codec

Signed-off-by: Jelle van der Waa <jelle@vdwaa.nl>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
index 861a4a6..067f365 100644
--- a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
+++ b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
@@ -111,6 +111,11 @@
 	allwinner,pins = "PH2";
 };
 
+
+&codec {
+	status = "okay";
+};
+
 &cpu0 {
 	cpu-supply = <&reg_dcdc2>;
 };
-- 
2.5.0
