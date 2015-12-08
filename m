From: lee.jones@linaro.org (Lee Jones)
Date: Tue,  8 Dec 2015 14:31:58 +0000
Subject: [PATCH v5 05/11] ARM: STi: STiH407: Provide CPU with clocking
 information
In-Reply-To: <1449585124-15596-1-git-send-email-lee.jones@linaro.org>
References: <1449585124-15596-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1449585124-15596-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 9fa1e58..af9233b 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -31,6 +31,10 @@
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
