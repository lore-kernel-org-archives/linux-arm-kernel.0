From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 19 Jan 2017 14:45:19 +0100
Subject: [PATCH 3/3] ARM: dts: stm32: enable RTC on stm32746g-eval
In-Reply-To: <1484833519-9298-1-git-send-email-amelie.delaunay@st.com>
References: <1484833519-9298-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1484833519-9298-4-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables RTC on stm32746g-eval with default LSE clock source.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32746g-eval.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/stm32746g-eval.dts b/arch/arm/boot/dts/stm32746g-eval.dts
index 58d5393..ae64ea4 100644
--- a/arch/arm/boot/dts/stm32746g-eval.dts
+++ b/arch/arm/boot/dts/stm32746g-eval.dts
@@ -82,6 +82,10 @@
 	};
 };
 
+&rtc {
+	status = "okay";
+};
+
 &usart1 {
 	pinctrl-0 = <&usart1_pins_a>;
 	pinctrl-names = "default";
-- 
1.9.1
