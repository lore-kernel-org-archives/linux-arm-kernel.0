From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 17 May 2018 14:07:07 +0200
Subject: [PATCH v2 2/3] ARM: dts: stm32: enable RTC on stm32mp157c-ed1
In-Reply-To: <1526558828-24456-1-git-send-email-amelie.delaunay@st.com>
References: <1526558828-24456-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1526558828-24456-3-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable RTC (Real Time Clock) on stm32mp157c-ed1 board.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32mp157c-ed1.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/stm32mp157c-ed1.dts
index ae33653..050c30d 100644
--- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
@@ -68,6 +68,10 @@
 	status = "okay";
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
