From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 22 Apr 2015 16:43:57 -0600
Subject: [PATCH] coresight: binding for ETMv4 coresight drivers
Message-ID: <1429742637-12337-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding compatible string for new coresight ETMv4 tracer.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 Documentation/devicetree/bindings/arm/coresight.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index 88602b75418e..f4d6a86738a4 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -17,6 +17,7 @@ its hardware characteristcs.
 		- "arm,coresight-tmc", "arm,primecell";
 		- "arm,coresight-funnel", "arm,primecell";
 		- "arm,coresight-etm3x", "arm,primecell";
+		- "arm,coresight-etm4x", "arm,primecell";
 
 	* reg: physical base address and length of the register
 	  set(s) of the component.
-- 
1.9.1
