From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Fri, 16 Feb 2018 14:16:40 +0100
Subject: [PATCH 2/2] ARM: dts: stm32: enable RTC on stm32h743i-eval
In-Reply-To: <1518787000-10675-1-git-send-email-amelie.delaunay@st.com>
References: <1518787000-10675-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1518787000-10675-3-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables RTC on stm32h743i-eval.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32h743i-eval.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/stm32h743i-eval.dts b/arch/arm/boot/dts/stm32h743i-eval.dts
index 9f0e72c..cc8e458 100644
--- a/arch/arm/boot/dts/stm32h743i-eval.dts
+++ b/arch/arm/boot/dts/stm32h743i-eval.dts
@@ -84,6 +84,10 @@
 	clock-frequency = <25000000>;
 };
 
+&rtc {
+	status = "okay";
+};
+
 &usart1 {
 	pinctrl-0 = <&usart1_pins>;
 	pinctrl-names = "default";
-- 
2.7.4
