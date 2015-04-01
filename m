From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Wed, 1 Apr 2015 17:17:31 +0530
Subject: [RESEND PATCH 1/8] Documentation: DT: Add entry for FSL LS2085A QDS
 and RDB boards
In-Reply-To: <1427888858-29636-1-git-send-email-bhupesh.sharma@freescale.com>
References: <1427888858-29636-1-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <1427888858-29636-2-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a devicetree binding documentation for FSL's
LS2085A QDS and RDB boards.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
---
 Documentation/devicetree/bindings/arm/fsl.txt |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index a5462b6..29b53a7 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -132,3 +132,11 @@ LS2085A ARMv8 based Simulator model
 Required root node properties:
     - compatible = "fsl,ls2085a-simu", "fsl,ls2085a";
 
+LS2085A ARMv8 based QDS Board
+Required root node properties:
+    - compatible = "fsl,ls2085a-qds", "fsl,ls2085a";
+
+LS2085A ARMv8 based RDB Board
+Required root node properties:
+    - compatible = "fsl,ls2085a-rdb", "fsl,ls2085a";
+
-- 
1.7.9.5
