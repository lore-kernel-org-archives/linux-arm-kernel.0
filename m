From: gdjakov@mm-sol.com (Georgi Djakov)
Date: Sat, 31 May 2014 18:45:31 +0300
Subject: [PATCH v2 1/4] clk: qcom: Add APQ8084 Global Clock Controller
 documentation
In-Reply-To: <1401551134-28485-1-git-send-email-gdjakov@mm-sol.com>
References: <1401551134-28485-1-git-send-email-gdjakov@mm-sol.com>
Message-ID: <1401551134-28485-2-git-send-email-gdjakov@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the compatible string for the APQ8084 global clock controller
to the clock binding documentation.

Signed-off-by: Georgi Djakov <gdjakov@mm-sol.com>
---
 .../devicetree/bindings/clock/qcom,gcc.txt         |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.txt b/Documentation/devicetree/bindings/clock/qcom,gcc.txt
index 7b7104e..13fc1ef 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc.txt
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc.txt
@@ -5,6 +5,7 @@ Required properties :
 - compatible : shall contain only one of the following:
 
 			"qcom,gcc-apq8064"
+			"qcom,gcc-apq8084"
 			"qcom,gcc-msm8660"
 			"qcom,gcc-msm8960"
 			"qcom,gcc-msm8974"
-- 
1.7.9.5
