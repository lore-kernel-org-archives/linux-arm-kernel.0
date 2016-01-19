From: lakshmi.sai.krishna.potthuri@xilinx.com (P L Sai Krishna)
Date: Tue, 19 Jan 2016 19:47:34 +0530
Subject: [LINUX PATCH 4/5] Documentation: mmc: Updated the binding doc for
 Arasan SDHCI.
In-Reply-To: <1453213055-35563-1-git-send-email-lakshmis@xilinx.com>
References: <1453213055-35563-1-git-send-email-lakshmis@xilinx.com>
Message-ID: <1453213055-35563-4-git-send-email-lakshmis@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds broken-mmc-highspeed property to the binding
doc for Arasan SDHCI.

Signed-off-by: P L Sai Krishna <lakshmis@xilinx.com>
---
 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index 2088d9f..5884832 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -20,7 +20,8 @@ Required Properties:
 Optional Properties:
   - broken-tuning: Indicates tuning broken in Silicon 1.0 of
 			  Zynq Ultrascale+ MPSoC.
-
+  - broken-mmc-highspeed: Indicates to force
+				the controller to use in standard speed.
 Example:
 	sdhci at e0100000 {
 		compatible = "arasan,sdhci-8.9a";
-- 
2.1.2
