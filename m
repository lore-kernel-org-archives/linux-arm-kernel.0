From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue,  9 Jan 2018 10:33:38 +0100
Subject: [PATCH v2 07/16] dt-bindings: iio: adc: axp20x_adc: add AXP813 variant
In-Reply-To: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
References: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
Message-ID: <64b538aadf075ba07e567d9a9db865b64c97fbfc.1515486346.git-series.quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AXP813 is now supported so add documentation for this compatible.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt |  9 +++++++++-
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt b/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
index ed6d04e..3465f80 100644
--- a/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
@@ -4,6 +4,7 @@ Required properties:
   - compatible: should be one of:
     - "x-powers,axp20x-adc",
     - "x-powers,axp22x-adc",
+    - "x-powers,axp813-adc",
   - #io-channel-cells: should be 1,
 
 Example:
@@ -37,3 +38,11 @@ AXP22x
  1 | batt_v
  2 | batt_chrg_i
  3 | batt_dischrg_i
+
+AXP813
+------
+ 0 | pmic_temp
+ 1 | gpio0_v
+ 2 | batt_v
+ 3 | batt_chrg_i
+ 4 | batt_dischrg_i
-- 
git-series 0.9.1
