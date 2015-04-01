From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Wed, 1 Apr 2015 17:17:32 +0530
Subject: [RESEND PATCH 2/8] doc/bindings: Update PCIe devicetree binding
 documentation for LS2085A
In-Reply-To: <1427888858-29636-1-git-send-email-bhupesh.sharma@freescale.com>
References: <1427888858-29636-1-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <1427888858-29636-3-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the documentation for compatible string "fsl,ls2085a-pcie"
for LS2085A platform.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
Reviewed-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
---
 .../devicetree/bindings/pci/layerscape-pci.txt     |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
index 6286f04..0654809 100644
--- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
+++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
@@ -4,7 +4,8 @@ This PCIe host controller is based on the Synopsis Designware PCIe IP
 and thus inherits all the common properties defined in designware-pcie.txt.
 
 Required properties:
-- compatible: should contain the platform identifier such as "fsl,ls1021a-pcie"
+- compatible: should contain the platform identifier such as "fsl,ls1021a-pcie",
+  "fsl,ls2085a-pcie".
 - reg: base addresses and lengths of the PCIe controller
 - interrupts: A list of interrupt outputs of the controller. Must contain an
   entry for each entry in the interrupt-names property.
-- 
1.7.9.5
