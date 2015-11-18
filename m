From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 17 Nov 2015 17:12:26 -0800
Subject: [PATCH 1/4] devicetree: bindings: Document Kryo cpu
In-Reply-To: <1447809149-29724-1-git-send-email-sboyd@codeaurora.org>
References: <1447809149-29724-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1447809149-29724-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the compatible string for the Kryo family of qcom cpus.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 3a07a87fef20..6008b99ccb2b 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -177,6 +177,7 @@ nodes to be present and contain the properties described below.
 			    "marvell,sheeva-v5"
 			    "nvidia,tegra132-denver"
 			    "qcom,krait"
+			    "qcom,kryo"
 			    "qcom,scorpion"
 	- enable-method
 		Value type: <stringlist>
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
