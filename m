From: lakshmi.sai.krishna.potthuri@xilinx.com (P L Sai Krishna)
Date: Tue, 19 Jan 2016 19:47:32 +0530
Subject: [LINUX PATCH 2/5] Documentation: mmc: Updated the binding doc for
 Arasan SDHCI.
In-Reply-To: <1453213055-35563-1-git-send-email-lakshmis@xilinx.com>
References: <1453213055-35563-1-git-send-email-lakshmis@xilinx.com>
Message-ID: <1453213055-35563-2-git-send-email-lakshmis@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds broken-tuning property to the binding
doc for Arasan SDHCI.

Signed-off-by: P L Sai Krishna <lakshmis@xilinx.com>
---
 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index da541c3..2088d9f 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -17,6 +17,10 @@ Required Properties:
   - interrupt-parent: Phandle for the interrupt controller that services
 		      interrupts for this device.
 
+Optional Properties:
+  - broken-tuning: Indicates tuning broken in Silicon 1.0 of
+			  Zynq Ultrascale+ MPSoC.
+
 Example:
 	sdhci at e0100000 {
 		compatible = "arasan,sdhci-8.9a";
-- 
2.1.2
