From: vkale@apm.com (Vinayak Kale)
Date: Thu, 20 Mar 2014 15:17:26 +0530
Subject: [PATCH 1/2] dt-bindings: Add Potenza PMU binding
In-Reply-To: <1395308847-16317-1-git-send-email-vkale@apm.com>
References: <1395308847-16317-1-git-send-email-vkale@apm.com>
Message-ID: <1395308847-16317-2-git-send-email-vkale@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch documents the compatible string for APM X-Gene Potenza CPU's PMU.

Signed-off-by: Vinayak Kale <vkale@apm.com>
---
 Documentation/devicetree/bindings/arm/pmu.txt |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/pmu.txt b/Documentation/devicetree/bindings/arm/pmu.txt
index 3e1e498..0246f81 100644
--- a/Documentation/devicetree/bindings/arm/pmu.txt
+++ b/Documentation/devicetree/bindings/arm/pmu.txt
@@ -7,6 +7,7 @@ representation in the device tree should be done as under:-
 Required properties:
 
 - compatible : should be one of
+	"apm,potenza-pmu"
 	"arm,armv8-pmuv3"
 	"arm,cortex-a15-pmu"
 	"arm,cortex-a9-pmu"
-- 
1.7.9.5
