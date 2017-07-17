From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Mon, 17 Jul 2017 10:36:05 +0200
Subject: [PATCH 3/3] ARM: dts: stm32: Remove rdinit from bootargs on
 stm32f429-disco
In-Reply-To: <1500280565-26049-1-git-send-email-alexandre.torgue@st.com>
References: <1500280565-26049-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1500280565-26049-4-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rootfs is independent from the board.

Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
index ae47cde..c66d617 100644
--- a/arch/arm/boot/dts/stm32f429-disco.dts
+++ b/arch/arm/boot/dts/stm32f429-disco.dts
@@ -54,7 +54,7 @@
 	compatible = "st,stm32f429i-disco", "st,stm32f429";
 
 	chosen {
-		bootargs = "root=/dev/ram rdinit=/linuxrc";
+		bootargs = "root=/dev/ram";
 		stdout-path = "serial0:115200n8";
 	};
 
-- 
1.9.1
