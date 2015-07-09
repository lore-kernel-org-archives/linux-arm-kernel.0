From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  9 Jul 2015 16:35:26 +0100
Subject: [PATCH 1/3] regulator: pwm-regulator: Ensure headings aren't confused
 with properties
Message-ID: <1436456128-18278-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We're using capitalisation and removing the '-' to mitigate confusion.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/devicetree/bindings/regulator/pwm-regulator.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/pwm-regulator.txt b/Documentation/devicetree/bindings/regulator/pwm-regulator.txt
index 892b366..23b4772 100644
--- a/Documentation/devicetree/bindings/regulator/pwm-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/pwm-regulator.txt
@@ -3,7 +3,7 @@ Bindings for the Generic PWM Regulator
 
 Currently supports 2 modes of operation:
 
-voltage-table:		When in this mode, a voltage table (See below) of
+Voltage Table:		When in this mode, a voltage table (See below) of
 			predefined voltage <=> duty-cycle values must be
 			provided via DT. Limitations are that the regulator can
 			only operate at the voltages supplied in the table.
@@ -13,7 +13,7 @@ voltage-table:		When in this mode, a voltage table (See below) of
 			the user if the assumptions made in continuous-voltage
 			mode do not reign true.
 
-continuous-voltage:	This mode uses the regulator's maximum and minimum
+Continuous Voltage:	This mode uses the regulator's maximum and minimum
 			supplied voltages specified in the
 			regulator-{min,max}-microvolt properties to calculate
 			appropriate duty-cycle values.  This allows for a much
-- 
1.9.1
