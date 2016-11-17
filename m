From: yuantian.tang@nxp.com (yuantian.tang at nxp.com)
Date: Thu, 17 Nov 2016 15:59:19 +0800
Subject: [PATCH 1/2] dt-bindings: ahci-fsl-qoriq: added explanation for
 reg-names
Message-ID: <1479369560-9188-1-git-send-email-yuantian.tang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tang Yuantian <Yuantian.Tang@nxp.com>

Added explanation for reg-names to make it more clear.

Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
---
 Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt b/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
index fc33ca0..80cf10c 100644
--- a/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
@@ -10,6 +10,8 @@ Required properties:
 Optional properties:
   - dma-coherent: Enable AHCI coherent DMA operation.
   - reg-names: register area names when there are more than 1 register area.
+		example: 'ahci' is for sata controller register.
+			 'sata-ecc' is for sata ecc register.
 
 Examples:
 	sata at 3200000 {
-- 
2.1.0.27.g96db324
