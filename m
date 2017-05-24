From: leo.yan@linaro.org (Leo Yan)
Date: Wed, 24 May 2017 08:02:56 +0800
Subject: [PATCH v12 8/9] arm64: dts: hi6220: register debug module
In-Reply-To: <1495584177-32193-1-git-send-email-leo.yan@linaro.org>
References: <1495584177-32193-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1495584177-32193-9-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bind debug module driver for Hi6220.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 64 +++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 1e5129b..21805b9 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -916,5 +916,69 @@
 				};
 			};
 		};
+
+		debug at f6590000 {
+			compatible = "arm,coresight-cpu-debug","arm,primecell";
+			reg = <0 0xf6590000 0 0x1000>;
+			clocks = <&sys_ctrl HI6220_DAPB_CLK>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu0>;
+		};
+
+		debug at f6592000 {
+			compatible = "arm,coresight-cpu-debug","arm,primecell";
+			reg = <0 0xf6592000 0 0x1000>;
+			clocks = <&sys_ctrl HI6220_DAPB_CLK>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu1>;
+		};
+
+		debug at f6594000 {
+			compatible = "arm,coresight-cpu-debug","arm,primecell";
+			reg = <0 0xf6594000 0 0x1000>;
+			clocks = <&sys_ctrl HI6220_DAPB_CLK>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu2>;
+		};
+
+		debug at f6596000 {
+			compatible = "arm,coresight-cpu-debug","arm,primecell";
+			reg = <0 0xf6596000 0 0x1000>;
+			clocks = <&sys_ctrl HI6220_DAPB_CLK>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu3>;
+		};
+
+		debug at f65d0000 {
+			compatible = "arm,coresight-cpu-debug","arm,primecell";
+			reg = <0 0xf65d0000 0 0x1000>;
+			clocks = <&sys_ctrl HI6220_DAPB_CLK>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu4>;
+		};
+
+		debug at f65d2000 {
+			compatible = "arm,coresight-cpu-debug","arm,primecell";
+			reg = <0 0xf65d2000 0 0x1000>;
+			clocks = <&sys_ctrl HI6220_DAPB_CLK>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu5>;
+		};
+
+		debug at f65d4000 {
+			compatible = "arm,coresight-cpu-debug","arm,primecell";
+			reg = <0 0xf65d4000 0 0x1000>;
+			clocks = <&sys_ctrl HI6220_DAPB_CLK>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu6>;
+		};
+
+		debug at f65d6000 {
+			compatible = "arm,coresight-cpu-debug","arm,primecell";
+			reg = <0 0xf65d6000 0 0x1000>;
+			clocks = <&sys_ctrl HI6220_DAPB_CLK>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu7>;
+		};
 	};
 };
-- 
2.7.4
