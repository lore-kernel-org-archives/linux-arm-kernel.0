From: Yuantian.Tang@freescale.com (Tang Yuantian)
Date: Thu, 29 Oct 2015 14:22:17 +0800
Subject: [PATCH 3/3] devicetree: bindings: Fixed a few typos
In-Reply-To: <1446099737-41854-1-git-send-email-Yuantian.Tang@freescale.com>
References: <1446099737-41854-1-git-send-email-Yuantian.Tang@freescale.com>
Message-ID: <1446099737-41854-3-git-send-email-Yuantian.Tang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a few typos in Freescale QorIQ AHCI bindings, This
patch fixed them.

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
---
 Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt b/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
index 3aafe27..032a760 100644
--- a/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
@@ -8,8 +8,8 @@ Required properties:
   - interrupts: Interrupt specifier. Refer to interrupt binding.
 
 Optional properties:
-  - dma-coherent: Enable ACHI coherency DMA operation.
-  - reg-names: register area names when there are more then 1 regster area.
+  - dma-coherent: Enable AHCI coherent DMA operation.
+  - reg-names: register area names when there are more than 1 register area.
 
 Examples:
 	sata at 3200000 {
-- 
2.1.0.27.g96db324
