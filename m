From: varada@codeaurora.org (Varadarajan Narayanan)
Date: Thu,  1 Jun 2017 16:57:59 +0530
Subject: [PATCH v3 2/5] dt-bindings: qcom: Add IPQ8074 bindings
In-Reply-To: <1496316482-25468-1-git-send-email-varada@codeaurora.org>
References: <1496316482-25468-1-git-send-email-varada@codeaurora.org>
Message-ID: <1496316482-25468-3-git-send-email-varada@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
---
 Documentation/devicetree/bindings/arm/qcom.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.txt b/Documentation/devicetree/bindings/arm/qcom.txt
index 028d16e..0ed4d39 100644
--- a/Documentation/devicetree/bindings/arm/qcom.txt
+++ b/Documentation/devicetree/bindings/arm/qcom.txt
@@ -25,6 +25,7 @@ The 'SoC' element must be one of the following strings:
 	msm8994
 	msm8996
 	mdm9615
+	ipq8074
 
 The 'board' element must be one of the following strings:
 
@@ -33,6 +34,7 @@ The 'board' element must be one of the following strings:
 	dragonboard
 	mtp
 	sbc
+	hk01
 
 The 'soc_version' and 'board_version' elements take the form of v<Major>.<Minor>
 where the minor number may be omitted when it's zero, i.e.  v1.0 is the same
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
