From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 21 Apr 2016 16:07:41 +0100
Subject: [[PATCH v2] 2/8] ARM: dts: STi: STiH407: Provide CPU with clocking
 information
In-Reply-To: <1461251267-14897-1-git-send-email-lee.jones@linaro.org>
References: <1461251267-14897-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1461251267-14897-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
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
2.8.0
