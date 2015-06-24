From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 24 Jun 2015 14:59:01 +0100
Subject: [PATCH v2 2/9] ARM: STi: STiH407: Provide CPU with clocking
 information
In-Reply-To: <1435154348-28840-1-git-send-email-lee.jones@linaro.org>
References: <1435154348-28840-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1435154348-28840-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 2680ac7..fcab003 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -27,6 +27,10 @@
 					    1200000 0
 					    800000  0
 					    500000  0>;
+
+			clocks = <&clk_m_a9>;
+			clock-names = "cpu";
+			clock-latency = <100000>;
 		};
 		cpu at 1 {
 			device_type = "cpu";
-- 
1.9.1
