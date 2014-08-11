From: fkan@apm.com (Feng Kan)
Date: Mon, 11 Aug 2014 16:47:33 -0700
Subject: [PATCH Resend 2/2] arm64: dts: Add PMU node for APM X-Gene Storm SOC
In-Reply-To: <1407800853-3149-1-git-send-email-fkan@apm.com>
References: <1407800853-3149-1-git-send-email-fkan@apm.com>
Message-ID: <1407800853-3149-3-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the PMU device tree node for APM X-Gene Storm SOC.

Signed-off-by: Feng Kan <fkan@apm.com>
---
 arch/arm64/boot/dts/apm-storm.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index 40aa96c..a2bb25e 100644
--- a/arch/arm64/boot/dts/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm-storm.dtsi
@@ -97,6 +97,11 @@
 		clock-frequency = <50000000>;
 	};
 
+	pmu {
+		compatible = "apm,potenza-pmu", "arm,armv8-pmuv3";
+		interrupts = <1 12 0xff04>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
-- 
1.9.1
