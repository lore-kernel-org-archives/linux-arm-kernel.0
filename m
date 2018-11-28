From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Wed, 28 Nov 2018 19:20:53 +0530
Subject: [PATCH v3 02/15] dt-bindings: arm: Document RDA8810PL and reference
 boards
In-Reply-To: <20181128135106.9255-1-manivannan.sadhasivam@linaro.org>
References: <20181128135106.9255-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20181128135106.9255-3-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andreas F?rber <afaerber@suse.de>

Add bindings for RDA Micro RDA8810PL SoC and below reference boards:

1. Orange Pi 2G-IoT - http://www.orangepi.org/OrangePi2GIOT/
2. Orange Pi i96 - https://www.96boards.org/product/orangepi-i96/

Cc: overseas.sales at unisoc.com
Cc: zhao_steven at 263.net
Signed-off-by: Andreas F?rber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/arm/rda.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/rda.txt

diff --git a/Documentation/devicetree/bindings/arm/rda.txt b/Documentation/devicetree/bindings/arm/rda.txt
new file mode 100644
index 000000000000..43c80762c428
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/rda.txt
@@ -0,0 +1,17 @@
+RDA Micro platforms device tree bindings
+----------------------------------------
+
+RDA8810PL SoC
+=============
+
+Required root node properties:
+
+ - compatible :  must contain "rda,8810pl"
+
+
+Boards:
+
+Root node property compatible must contain, depending on board:
+
+ - Orange Pi 2G-IoT: "xunlong,orangepi-2g-iot"
+ - Orange Pi i96: "xunlong,orangepi-i96"
-- 
2.17.1
