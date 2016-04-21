From: ashoks@broadcom.com (Ashok Kumar)
Date: Thu, 21 Apr 2016 05:58:40 -0700
Subject: [PATCH v6 2/7] arm64: dts: Add Broadcom Vulcan PMU in dts
In-Reply-To: <1461243525-13603-1-git-send-email-ashoks@broadcom.com>
References: <1461243525-13603-1-git-send-email-ashoks@broadcom.com>
Message-ID: <1461243525-13603-3-git-send-email-ashoks@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "brcm,vulcan-pmu" compatible string for Broadcom Vulcan PMU.

Signed-off-by: Ashok Kumar <ashoks@broadcom.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/boot/dts/broadcom/vulcan.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/broadcom/vulcan.dtsi b/arch/arm64/boot/dts/broadcom/vulcan.dtsi
index 85820e2..34e11a9 100644
--- a/arch/arm64/boot/dts/broadcom/vulcan.dtsi
+++ b/arch/arm64/boot/dts/broadcom/vulcan.dtsi
@@ -86,7 +86,7 @@
 	};
 
 	pmu {
-		compatible = "arm,armv8-pmuv3";
+		compatible = "brcm,vulcan-pmu", "arm,armv8-pmuv3";
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>; /* PMU overflow */
 	};
 
-- 
2.1.0
