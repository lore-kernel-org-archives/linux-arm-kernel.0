From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Mon, 17 Jul 2017 10:36:03 +0200
Subject: [PATCH 1/3] ARM: dts: stm32: Remove rdinit from bootargs on
 stm32f469-disco
In-Reply-To: <1500280565-26049-1-git-send-email-alexandre.torgue@st.com>
References: <1500280565-26049-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1500280565-26049-2-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rootfs is independent from the board.

Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
index 75470c3..6ae1f03 100644
--- a/arch/arm/boot/dts/stm32f469-disco.dts
+++ b/arch/arm/boot/dts/stm32f469-disco.dts
@@ -53,7 +53,7 @@
 	compatible = "st,stm32f469i-disco", "st,stm32f469";
 
 	chosen {
-		bootargs = "root=/dev/ram rdinit=/linuxrc";
+		bootargs = "root=/dev/ram";
 		stdout-path = "serial0:115200n8";
 	};
 
-- 
1.9.1
