From: galak@codeaurora.org (Kumar Gala)
Date: Wed,  4 Mar 2015 13:57:25 -0600
Subject: [PATCH] arm: qcom: dts: gic: add compatible string for Qualcomm MSM
 GICs
Message-ID: <1425499045-31450-1-git-send-email-galak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the Qualcomm MSM GICs implementation as compatible with the
ARM GIC standard.

Signed-off-by: Kumar Gala <galak@codeaurora.org>
---
 Documentation/devicetree/bindings/arm/gic.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
index c97484b..6204630 100644
--- a/Documentation/devicetree/bindings/arm/gic.txt
+++ b/Documentation/devicetree/bindings/arm/gic.txt
@@ -18,6 +18,8 @@ Main node required properties:
 	"arm,arm11mp-gic"
 	"brcm,brahma-b15-gic"
 	"arm,arm1176jzf-devchip-gic"
+	"qcom,msm-8660-qgic"
+	"qcom,msm-qgic2"
 - interrupt-controller : Identifies the node as an interrupt controller
 - #interrupt-cells : Specifies the number of cells needed to encode an
   interrupt source.  The type shall be a <u32> and the value shall be 3.
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
