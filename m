From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed,  8 Jan 2014 14:59:43 -0800
Subject: [PATCH 6/7] devicetree: bindings: Document Krait performance monitor
 units (PMU)
In-Reply-To: <1389221984-10973-1-git-send-email-sboyd@codeaurora.org>
References: <1389221984-10973-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1389221984-10973-7-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the Krait PMU compatible string.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 Documentation/devicetree/bindings/arm/pmu.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/pmu.txt b/Documentation/devicetree/bindings/arm/pmu.txt
index 3e1e498fea96..ce7cccb99d87 100644
--- a/Documentation/devicetree/bindings/arm/pmu.txt
+++ b/Documentation/devicetree/bindings/arm/pmu.txt
@@ -16,6 +16,7 @@ Required properties:
 	"arm,arm11mpcore-pmu"
 	"arm,arm1176-pmu"
 	"arm,arm1136-pmu"
+	"qcom,krait-pmu"
 - interrupts : 1 combined interrupt or 1 per core.
 
 Example:
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
