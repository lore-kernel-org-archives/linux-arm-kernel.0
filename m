From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 22 Jun 2015 16:43:52 +0100
Subject: [PATCH 3/8] ARM: STi: STiH407: Link CPU with its voltage supply
In-Reply-To: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1434987837-24212-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Used for Voltage Scaling using CPUFreq.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index fcab003..f48767e 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -31,6 +31,7 @@
 			clocks = <&clk_m_a9>;
 			clock-names = "cpu";
 			clock-latency = <100000>;
+			cpu0-supply = <&pwm_regulator>;
 		};
 		cpu at 1 {
 			device_type = "cpu";
-- 
1.9.1
