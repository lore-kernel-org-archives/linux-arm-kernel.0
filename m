From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Wed, 3 Sep 2014 20:43:10 +0530
Subject: [PATCH V3 2/6] Documentation: DT: Add entry for FSL LS2085A SoC and
 Simulator model
In-Reply-To: <1409757194-28155-1-git-send-email-bhupesh.sharma@freescale.com>
References: <1409757194-28155-1-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <1409757194-28155-3-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a devicetree binding documentation for FSL's
LS2085A SoC and Simulator model.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
---
 Documentation/devicetree/bindings/arm/fsl.txt |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index e935d7d..3b28c4d 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -74,3 +74,11 @@ Required root node properties:
 i.MX6q generic board
 Required root node properties:
     - compatible = "fsl,imx6q";
+
+Freescale LS2085A SoC Device Tree Bindings
+------------------------------------------
+
+LS2085A ARMv8 based Simulator model
+Required root node properties:
+    - compatible = "fsl,ls2085a-simu", "fsl,ls2085a";
+
-- 
1.7.9.5
