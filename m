From: carlo@caione.org (Carlo Caione)
Date: Tue, 30 May 2017 11:05:06 +0200
Subject: [PATCH v4 1/2] Documentation: bindings: add amlogic,
 meson-gxbb-scpi-sensors compatible
In-Reply-To: <20170530090507.16611-1-carlo@caione.org>
References: <20170530090507.16611-1-carlo@caione.org>
Message-ID: <20170530090507.16611-2-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Introduce a new Amlogic specific compatible to handle how Amlogic reports
the sensor readings from SCPI using a different scale.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 Documentation/devicetree/bindings/arm/arm,scpi.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/arm,scpi.txt b/Documentation/devicetree/bindings/arm/arm,scpi.txt
index 4018319..40f50c1 100644
--- a/Documentation/devicetree/bindings/arm/arm,scpi.txt
+++ b/Documentation/devicetree/bindings/arm/arm,scpi.txt
@@ -76,7 +76,7 @@ Sensor bindings for the sensors based on SCPI Message Protocol
 SCPI provides an API to access the various sensors on the SoC.
 
 Required properties:
-- compatible : should be "arm,scpi-sensors".
+- compatible : should be "arm,scpi-sensors" or "amlogic,meson-gxbb-scpi-sensors"
 - #thermal-sensor-cells: should be set to 1. This property follows the
 			 thermal device tree bindings[2].
 
-- 
2.9.3
