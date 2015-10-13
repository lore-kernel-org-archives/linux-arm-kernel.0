From: michael.opdenacker@free-electrons.com (Michael Opdenacker)
Date: Tue, 13 Oct 2015 13:33:18 +0200
Subject: [PATCH] ARM: dts: msm8974: fix typo in "disabled" property
Message-ID: <1444735998-18479-1-git-send-email-michael.opdenacker@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace "disable" by "disabled" in the Qualcomm MSM8974 dtsi

Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index ab8e57250468..8c87203b6429 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -308,7 +308,7 @@
 		};
 
 		blsp_i2c11: i2c at f9967000 {
-			status = "disable";
+			status = "disabled";
 			compatible = "qcom,i2c-qup-v2.1.1";
 			reg = <0xf9967000 0x1000>;
 			interrupts = <0 105 IRQ_TYPE_NONE>;
-- 
2.1.4
