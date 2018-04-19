From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 19 Apr 2018 16:35:25 +0200
Subject: [PATCH 2/2] ARM: dts: stm32: enable RTC on stm32mp157c-ed1
In-Reply-To: <1524148525-25209-1-git-send-email-amelie.delaunay@st.com>
References: <1524148525-25209-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1524148525-25209-3-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable RTC (Real Time Clock) on stm32mp157c-ed1 board.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32mp157c-ed1.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/stm32mp157c-ed1.dts
index 9f90337a..f9c4f8f 100644
--- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
@@ -25,6 +25,10 @@
 	};
 };
 
+&rtc {
+	status = "okay";
+};
+
 &uart4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart4_pins_a>;
-- 
2.7.4
