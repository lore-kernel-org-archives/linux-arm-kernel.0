From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu,  2 Jan 2014 16:37:40 -0800
Subject: [PATCH v2 10/10] devicetree: bindings: Document PM8921/8058 vibrators
In-Reply-To: <1388709460-19222-1-git-send-email-sboyd@codeaurora.org>
References: <1388709460-19222-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1388709460-19222-11-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the vibration device found on PM8921 and PM8058 PMICs.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 .../devicetree/bindings/input/qcom,pm8xxx-vib.txt        | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt

diff --git a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt
new file mode 100644
index 000000000000..dca1b8872cf1
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt
@@ -0,0 +1,16 @@
+Qualcomm PM8xxx PMIC Vibrator
+
+PROPERTIES
+
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: must be one of:
+		    "qcom,pm8058-vib"
+		    "qcom,pm8921-vib"
+
+EXAMPLE
+
+	vibrator {
+		compatible = "qcom,pm8058-vib";
+	};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
