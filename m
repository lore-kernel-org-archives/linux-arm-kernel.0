From: fkan@apm.com (Feng Kan)
Date: Mon, 11 Aug 2014 16:47:32 -0700
Subject: [PATCH Resend 1/2] dt-bindings: Add Potenza PMU binding
In-Reply-To: <1407800853-3149-1-git-send-email-fkan@apm.com>
References: <1407800853-3149-1-git-send-email-fkan@apm.com>
Message-ID: <1407800853-3149-2-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch documents the compatible string for APM X-Gene Potenza CPU's PMU.

Signed-off-by: Feng Kan <fkan@apm.com>
---
 Documentation/devicetree/bindings/arm/pmu.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/pmu.txt b/Documentation/devicetree/bindings/arm/pmu.txt
index 75ef91d..6d268b3 100644
--- a/Documentation/devicetree/bindings/arm/pmu.txt
+++ b/Documentation/devicetree/bindings/arm/pmu.txt
@@ -7,6 +7,7 @@ representation in the device tree should be done as under:-
 Required properties:
 
 - compatible : should be one of
+	"apm,potenza-pmu"
 	"arm,armv8-pmuv3"
 	"arm,cortex-a17-pmu"
 	"arm,cortex-a15-pmu"
-- 
1.9.1
