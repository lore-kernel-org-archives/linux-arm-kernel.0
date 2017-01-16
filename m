From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Mon, 16 Jan 2017 14:29:47 +0100
Subject: [PATCHv3 RESEND 6/8] ARM: dts: stm32: enable RTC on stm32f469-disco
In-Reply-To: <1484573388-590-1-git-send-email-amelie.delaunay@st.com>
References: <1484573388-590-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1484573388-590-4-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables RTC on stm32f469-disco with default LSE clock source.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32f469-disco.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
index fda12a4..f52b9f6 100644
--- a/arch/arm/boot/dts/stm32f469-disco.dts
+++ b/arch/arm/boot/dts/stm32f469-disco.dts
@@ -78,6 +78,10 @@
 	clock-frequency = <8000000>;
 };
 
+&rtc {
+	status = "okay";
+};
+
 &usart3 {
 	pinctrl-0 = <&usart3_pins_a>;
 	pinctrl-names = "default";
-- 
1.9.1
