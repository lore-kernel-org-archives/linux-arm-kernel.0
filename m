From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 24 Jul 2013 17:43:42 -0700
Subject: [PATCH v1 14/14] ARM: dts: msm: Add clock entries for MSM8960 uart
 device
In-Reply-To: <1374713022-6049-1-git-send-email-sboyd@codeaurora.org>
References: <1374713022-6049-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1374713022-6049-15-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/msm8960-cdp.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/msm8960-cdp.dts b/arch/arm/boot/dts/msm8960-cdp.dts
index be8d947..e10fba6 100644
--- a/arch/arm/boot/dts/msm8960-cdp.dts
+++ b/arch/arm/boot/dts/msm8960-cdp.dts
@@ -151,6 +151,8 @@
 		reg = <0x16440000 0x1000>,
 		      <0x16400000 0x1000>;
 		interrupts = <0 154 0x0>;
+		clocks = <&gsbi5_uart_clk>, <&gsbi5_uart_ahb>;
+		clock-names = "gsbi_uart_clk", "gsbi_pclk";
 	};
 
 	qcom,ssbi at 500000 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
