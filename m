From: shh.xie@gmail.com (shh.xie at gmail.com)
Date: Tue, 13 Sep 2016 16:09:57 +0800
Subject: [PATCH 04/10] [v3] dt-bindings: qoriq-clock: update for more SoCs
In-Reply-To: <1473754203-22970-1-git-send-email-shh.xie@gmail.com>
References: <1473754203-22970-1-git-send-email-shh.xie@gmail.com>
Message-ID: <1473754203-22970-5-git-send-email-shh.xie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shaohui Xie <Shaohui.Xie@nxp.com>

Adds compatible for SoCs which use clockgen, the SoCs are LS1043A,
LS1046A, LS2080A.

Signed-off-by: Shaohui Xie <Shaohui.Xie@nxp.com>
---
change in v3:
1. new patch.

 Documentation/devicetree/bindings/clock/qoriq-clock.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qoriq-clock.txt b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
index 16a3ec4..df9cb5a 100644
--- a/Documentation/devicetree/bindings/clock/qoriq-clock.txt
+++ b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
@@ -32,6 +32,9 @@ Required properties:
 	* "fsl,b4420-clockgen"
 	* "fsl,b4860-clockgen"
 	* "fsl,ls1021a-clockgen"
+	* "fsl,ls1043a-clockgen"
+	* "fsl,ls1046a-clockgen"
+	* "fsl,ls2080a-clockgen"
 	Chassis-version clock strings include:
 	* "fsl,qoriq-clockgen-1.0": for chassis 1.0 clocks
 	* "fsl,qoriq-clockgen-2.0": for chassis 2.0 clocks
-- 
2.1.0.27.g96db324
