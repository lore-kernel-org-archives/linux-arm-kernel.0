From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu,  8 Oct 2015 12:19:34 +0100
Subject: [PATCH 3/4] arm64: dts: apq8016-sbc: enable i2c buses on LS and HS
In-Reply-To: <1444303124-32402-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1444303124-32402-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1444303174-32532-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables i2c buses on low speed and high speed expansion
connectors on DB410C.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index 3fc3be4..3581272 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -86,3 +86,18 @@
 		};
 	};
 };
+
+&blsp_i2c2 {
+	/* On Low speed expansion */
+	status = "okay";
+};
+
+&blsp_i2c4 {
+	/* On High speed expansion */
+	status = "okay";
+};
+
+&blsp_i2c6 {
+	/* On Low speed expansion */
+	status = "okay";
+};
-- 
1.9.1
