From: yangbo.lu@nxp.com (Yangbo Lu)
Date: Fri, 22 Apr 2016 14:27:38 +0800
Subject: [v8, 1/7] Documentation: DT: update Freescale DCFG compatible
In-Reply-To: <1461306464-19521-1-git-send-email-yangbo.lu@nxp.com>
References: <1461306464-19521-1-git-send-email-yangbo.lu@nxp.com>
Message-ID: <1461306464-19521-2-git-send-email-yangbo.lu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update Freescale DCFG compatible with 'fsl,<chip>-dcfg' instead
of 'fsl,ls1021a-dcfg' to include more chips.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v8:
	- Added this patch
---
 Documentation/devicetree/bindings/arm/fsl.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index 752a685..1d5f512 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -119,7 +119,7 @@ Freescale DCFG
 configuration and status for the device. Such as setting the secondary
 core start address and release the secondary core from holdoff and startup.
   Required properties:
-  - compatible: should be "fsl,ls1021a-dcfg"
+  - compatible: should be "fsl,<chip>-dcfg"
   - reg : should contain base address and length of DCFG memory-mapped registers
 
 Example:
-- 
2.1.0.27.g96db324
