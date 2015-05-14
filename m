From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Thu, 14 May 2015 17:03:31 +0530
Subject: [PATCH v2 1/5] doc/bindings: Add 'endianess' optional-property for
 FlexCAN controller
In-Reply-To: <1431603215-25546-1-git-send-email-bhupesh.sharma@freescale.com>
References: <1431603215-25546-1-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <1431603215-25546-2-git-send-email-bhupesh.sharma@freescale.com>
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
