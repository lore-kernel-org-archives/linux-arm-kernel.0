From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Fri, 4 Sep 2015 12:27:44 +0530
Subject: [PATCH v2 02/10] Documentation: DT: Add entry for FSL LS2080A QDS and
 RDB boards
In-Reply-To: <1441349872-4560-1-git-send-email-bhupesh.sharma@freescale.com>
References: <1441349872-4560-1-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <1441349872-4560-3-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a devicetree binding documentation for Freescale's
LS2080A QDS and RDB boards.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
---
 Documentation/devicetree/bindings/arm/fsl.txt |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index 53f229a..34c88b0 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -135,3 +135,11 @@ LS2080A ARMv8 based Simulator model
 Required root node properties:
     - compatible = "fsl,ls2080a-simu", "fsl,ls2080a";
 
+LS2080A ARMv8 based QDS Board
+Required root node properties:
+    - compatible = "fsl,ls2080a-qds", "fsl,ls2080a";
+
+LS2080A ARMv8 based RDB Board
+Required root node properties:
+    - compatible = "fsl,ls2080a-rdb", "fsl,ls2080a";
+
-- 
1.7.9.5
