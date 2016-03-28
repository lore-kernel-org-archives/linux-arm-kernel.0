From: ashoks@broadcom.com (Ashok Kumar)
Date: Mon, 28 Mar 2016 05:23:43 -0700
Subject: [PATCH v3 6/6] Documentation: arm64: pmu: Add Broadcom Vulcan PMU
 binding
In-Reply-To: <1459167823-487-1-git-send-email-ashoks@broadcom.com>
References: <1459167823-487-1-git-send-email-ashoks@broadcom.com>
Message-ID: <1459167823-487-7-git-send-email-ashoks@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the compatible string for Broadcom Vulcan PMU.
Also arranged the list in alphabetical order.

Signed-off-by: Ashok Kumar <ashoks@broadcom.com>
---
 Documentation/devicetree/bindings/arm/pmu.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/pmu.txt b/Documentation/devicetree/bindings/arm/pmu.txt
index d3999a1..b73a7c7 100644
--- a/Documentation/devicetree/bindings/arm/pmu.txt
+++ b/Documentation/devicetree/bindings/arm/pmu.txt
@@ -22,10 +22,11 @@ Required properties:
 	"arm,arm11mpcore-pmu"
 	"arm,arm1176-pmu"
 	"arm,arm1136-pmu"
+	"brcm,vulcan-pmu"
+	"cavium,thunder-pmu"
 	"qcom,scorpion-pmu"
 	"qcom,scorpion-mp-pmu"
 	"qcom,krait-pmu"
-	"cavium,thunder-pmu"
 - interrupts : 1 combined interrupt or 1 per core. If the interrupt is a per-cpu
                interrupt (PPI) then 1 interrupt should be specified.
 
-- 
2.1.0
