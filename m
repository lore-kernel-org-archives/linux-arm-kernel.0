From: claudiu.beznea@microchip.com (Claudiu Beznea)
Date: Fri, 12 Jan 2018 16:22:50 +0200
Subject: [PATCH v2 03/16] pwm: cros-ec: update documentation regarding
 pwm-cells
In-Reply-To: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <1515766983-15151-4-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pwm-cells should be at least 2 to provide channel number and period value.

Cc: Brian Norris <briannorris@chromium.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
index 472bd46ab5a4..03347fd302b5 100644
--- a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
@@ -8,7 +8,7 @@ Documentation/devicetree/bindings/mfd/cros-ec.txt).
 
 Required properties:
 - compatible: Must contain "google,cros-ec-pwm"
-- #pwm-cells: Should be 1. The cell specifies the PWM index.
+- #pwm-cells: Should be 2. The cell specifies the PWM index.
 
 Example:
 	cros-ec at 0 {
@@ -18,6 +18,6 @@ Example:
 
 		cros_ec_pwm: ec-pwm {
 			compatible = "google,cros-ec-pwm";
-			#pwm-cells = <1>;
+			#pwm-cells = <2>;
 		};
 	};
-- 
2.7.4
