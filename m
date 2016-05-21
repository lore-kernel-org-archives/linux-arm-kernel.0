From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:36:48 +0200
Subject: [PATCH 0011/1529] Fix typo
Message-ID: <20160521113648.31841-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 Documentation/devicetree/bindings/arm/coresight.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index 93147c0c..a846d4b 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -6,7 +6,7 @@ SoCs tracing needs. These trace components can generally be classified as
 sinks, links and sources. Trace data produced by one or more sources flows
 through the intermediate links connecting the source to the currently selected
 sink. Each CoreSight component device should use these properties to describe
-its hardware characteristcs.
+its hardware characteristics.
 
 * Required properties for all components *except* non-configurable replicators:
 
-- 
2.8.2.534.g1f66975
