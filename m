From: leo.yan@linaro.org (Leo Yan)
Date: Tue,  2 May 2017 18:08:36 +0800
Subject: [PATCH v8 6/7] arm64: dts: hi6220: register debug module
In-Reply-To: <1493719717-27698-1-git-send-email-leo.yan@linaro.org>
References: <1493719717-27698-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1493719717-27698-7-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bind debug module driver for Hi6220.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 64 +++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 470461d..467aa15 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -913,5 +913,69 @@
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
