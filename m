From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Sat, 24 Oct 2015 01:01:52 +0530
Subject: [PATCH v4 03/12] Documentation: DT: Add entry for FSL LS2080A QDS and
 RDB boards
In-Reply-To: <1445628721-10483-1-git-send-email-bhupesh.sharma@freescale.com>
References: <1445628721-10483-1-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <1445628721-10483-4-git-send-email-bhupesh.sharma@freescale.com>
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
