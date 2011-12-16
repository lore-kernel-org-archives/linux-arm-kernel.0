From: richard.zhao@linaro.org (Richard Zhao)
Date: Fri, 16 Dec 2011 18:31:00 +0800
Subject: [PATCH V2 2/4] dts/imx6q: add cpufreq property
In-Reply-To: <1324031462-24961-1-git-send-email-richard.zhao@linaro.org>
References: <1324031462-24961-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1324031462-24961-3-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/boot/dts/imx6q.dtsi |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 263e8f3..f2e3eaf 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -29,6 +29,9 @@
 			compatible = "arm,cortex-a9";
 			reg = <0>;
 			next-level-cache = <&L2>;
+			cpu-freqs = <996000000 792000000 396000000 198000000>;
+			cpu-volts = <1225000 1100000 950000 850000>;
+			trans-latency = <61036>; /* two CLK32 periods */
 		};
 
 		cpu at 1 {
-- 
1.7.5.4
