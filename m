From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 5 Jan 2017 14:43:27 +0100
Subject: [PATCHv3 6/8] ARM: dts: stm32: enable RTC on stm32f469-disco
In-Reply-To: <1483623809-29937-1-git-send-email-amelie.delaunay@st.com>
References: <1483623809-29937-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1483623809-29937-7-git-send-email-amelie.delaunay@st.com>
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
