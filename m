From: baolin.wang@linaro.org (Baolin Wang)
Date: Mon, 23 Jul 2018 14:10:17 +0800
Subject: [PATCH 2/5] arm64: dts: sprd: Add SC27XX vibrator device
In-Reply-To: <2531014d066e61063b3d7906e6df55caa028e17c.1531881619.git.baolin.wang@linaro.org>
References: <2531014d066e61063b3d7906e6df55caa028e17c.1531881619.git.baolin.wang@linaro.org>
Message-ID: <30609aebce340ad7051323e45f989db80811e6e0.1531881619.git.baolin.wang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the vibrator device node for Spreadtrum SC27XX PMICs.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/sc2731.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
index 7d53ca6..650bd68 100644
--- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
@@ -57,6 +57,11 @@
 			#interrupt-cells = <2>;
 		};
 
+		vibrator at ec8 {
+			compatible = "sprd,sc27xx-vibrator", "sprd,sc2731-vibrator";
+			reg = <0xec8>;
+		};
+
 		regulators {
 			compatible = "sprd,sc27xx-regulator";
 
-- 
1.7.9.5
