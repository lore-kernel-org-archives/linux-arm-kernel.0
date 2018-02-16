From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Fri, 16 Feb 2018 14:47:12 +0100
Subject: [PATCH] ARM: dts: stm32: enable RTC on stm32f769-disco
Message-ID: <1518788832-21714-1-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables RTC on stm32f769-disco.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32f769-disco.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f769-disco.dts b/arch/arm/boot/dts/stm32f769-disco.dts
index 4463ca1..48cb47f 100644
--- a/arch/arm/boot/dts/stm32f769-disco.dts
+++ b/arch/arm/boot/dts/stm32f769-disco.dts
@@ -73,6 +73,10 @@
 	clock-frequency = <25000000>;
 };
 
+&rtc {
+	status = "okay";
+};
+
 &usart1 {
 	pinctrl-0 = <&usart1_pins_a>;
 	pinctrl-names = "default";
-- 
2.7.4
