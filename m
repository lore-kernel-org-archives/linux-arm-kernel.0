From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 22 Oct 2014 13:11:03 +0200
Subject: [PATCH v3 2/4] ARM: dts: sun4i: Add lradc node
In-Reply-To: <1413976265-12805-1-git-send-email-hdegoede@redhat.com>
References: <1413976265-12805-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1413976265-12805-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 380f914..1ef7d57 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -669,6 +669,13 @@
 			status = "disabled";
 		};
 
+		lradc: lradc at 01c22800 {
+			compatible = "allwinner,sun4i-a10-lradc-keys";
+			reg = <0x01c22800 0x100>;
+			interrupts = <31>;
+			status = "disabled";
+		};
+
 		sid: eeprom at 01c23800 {
 			compatible = "allwinner,sun4i-a10-sid";
 			reg = <0x01c23800 0x10>;
-- 
2.1.0
