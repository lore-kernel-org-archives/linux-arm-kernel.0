From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Thu, 9 Apr 2015 20:21:26 +0530
Subject: [PATCH 1/2] doc/bindings: Add 'endianess' optional-property for
 FlexCAN controller
Message-ID: <1428591087-12831-1-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds 'endianess' as the optional-property for
describing the FlexCAN controller present on various FSL platforms.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
Signed-off-by: Sakar Arora <Sakar.Arora@freescale.com>
---
 .../devicetree/bindings/net/can/fsl-flexcan.txt    |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
index 56d6cc3..0d5e668 100644
--- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
+++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
@@ -18,6 +18,10 @@ Optional properties:
 
 - xceiver-supply: Regulator that powers the CAN transceiver
 
+- little-endian: If the FlexCAN IP on this SoC is little-endian, use
+                 this property. By default it is assumed that the IP
+                 is big-endian
+
 Example:
 
 	can at 1c000 {
-- 
1.7.9.5
