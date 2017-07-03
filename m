From: varada@codeaurora.org (Varadarajan Narayanan)
Date: Mon,  3 Jul 2017 13:17:12 +0530
Subject: [PATCH v3 1/2] dts: ipq4019: Fix pinctrl node name
In-Reply-To: <1499068033-24000-1-git-send-email-varada@codeaurora.org>
References: <1499068033-24000-1-git-send-email-varada@codeaurora.org>
Message-ID: <1499068033-24000-2-git-send-email-varada@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi | 2 +-
 arch/arm/boot/dts/qcom-ipq4019.dtsi           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi b/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
index b9457dd..1ce253d 100644
--- a/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
@@ -40,7 +40,7 @@
 			clock-frequency = <48000000>;
 		};
 
-		pinctrl at 0x01000000 {
+		pinctrl at 1000000 {
 			serial_pins: serial_pinmux {
 				mux {
 					pins = "gpio60", "gpio61";
diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index b7a24af..6defd0e 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -119,7 +119,7 @@
 			reg = <0x1800000 0x60000>;
 		};
 
-		tlmm: pinctrl at 0x01000000 {
+		tlmm: pinctrl at 1000000 {
 			compatible = "qcom,ipq4019-pinctrl";
 			reg = <0x01000000 0x300000>;
 			gpio-controller;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
