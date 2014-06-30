From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 30 Jun 2014 23:57:55 +0200
Subject: [PATCH 5/9] ARM: dts: sun7i: Add ir receiver support to a20-i12-tvbox
In-Reply-To: <1404165479-23785-1-git-send-email-hdegoede@redhat.com>
References: <1404165479-23785-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1404165479-23785-6-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
index 4ee6b44..f620aea 100644
--- a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
+++ b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
@@ -105,6 +105,12 @@
 			};
 		};
 
+		ir0: ir at 01c21800 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&ir0_pins_a>;
+			status = "okay";
+		};
+
 		uart0: serial at 01c28000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart0_pins_a>;
-- 
2.0.0
