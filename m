From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Fri, 2 Dec 2016 15:09:59 +0100
Subject: [PATCH 6/8] ARM: dts: stm32: enable RTC on stm32f469-disco
In-Reply-To: <1480687801-19525-2-git-send-email-amelie.delaunay@st.com>
References: <1480687801-19525-2-git-send-email-amelie.delaunay@st.com>
Message-ID: <1480687801-19525-8-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables RTC on stm32f469-disco with default LSE clock source.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32f469-disco.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
index 8a163d7..af57dd5 100644
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
 	status = "okay";
 };
-- 
1.9.1
