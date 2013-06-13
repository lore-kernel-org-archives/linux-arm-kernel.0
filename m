From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 12 Jun 2013 18:49:09 -0700
Subject: [RFC/PATCH 13/13] ARM: dts: msm: Add clock entries for MSM8960 uart
 device
In-Reply-To: <1371088149-22562-1-git-send-email-sboyd@codeaurora.org>
References: <1371088149-22562-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1371088149-22562-14-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/msm8960-cdp.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/msm8960-cdp.dts b/arch/arm/boot/dts/msm8960-cdp.dts
index 1c0691c..caf13ae 100644
--- a/arch/arm/boot/dts/msm8960-cdp.dts
+++ b/arch/arm/boot/dts/msm8960-cdp.dts
@@ -162,6 +162,8 @@
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
