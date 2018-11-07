From: zhiqiang.hou@nxp.com (Z.q. Hou)
Date: Wed, 7 Nov 2018 05:35:17 +0000
Subject: [PATCHv3 1/4] dt-bindings: pci: layerscape-pci: add compatible
 strings "fsl,ls1043a-pcie"
In-Reply-To: <20181107053500.13575-1-Zhiqiang.Hou@nxp.com>
References: <20181107053500.13575-1-Zhiqiang.Hou@nxp.com>
Message-ID: <20181107053500.13575-2-Zhiqiang.Hou@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The PCIe compatible string for LS1043A was lost, so add it.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
V3:
 - no change

 Documentation/devicetree/bindings/pci/layerscape-pci.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
index 66df1e81e0b8..5eb1c202932f 100644
--- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
+++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
@@ -18,6 +18,7 @@ Required properties:
         "fsl,ls2088a-pcie"
         "fsl,ls1088a-pcie"
         "fsl,ls1046a-pcie"
+        "fsl,ls1043a-pcie"
         "fsl,ls1012a-pcie"
 - reg: base addresses and lengths of the PCIe controller register blocks.
 - interrupts: A list of interrupt outputs of the controller. Must contain an
-- 
2.17.1
