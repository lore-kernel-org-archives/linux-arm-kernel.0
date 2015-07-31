From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 31 Jul 2015 09:37:21 -0600
Subject: [PATCH 01/10] coresight: binding for ETMv4 coresight drivers
In-Reply-To: <1438357050-22486-1-git-send-email-mathieu.poirier@linaro.org>
References: <1438357050-22486-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1438357050-22486-2-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding compatible string for new coresight ETMv4 tracer.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 Documentation/devicetree/bindings/arm/coresight.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index 65a6db2271a2..62938eb9697f 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -17,6 +17,7 @@ its hardware characteristcs.
 		- "arm,coresight-tmc", "arm,primecell";
 		- "arm,coresight-funnel", "arm,primecell";
 		- "arm,coresight-etm3x", "arm,primecell";
+		- "arm,coresight-etm4x", "arm,primecell";
 		- "qcom,coresight-replicator1x", "arm,primecell";
 
 	* reg: physical base address and length of the register
-- 
1.9.1
