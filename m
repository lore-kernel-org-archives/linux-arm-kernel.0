From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Mon, 17 Jul 2017 10:36:04 +0200
Subject: [PATCH 2/3] ARM: dts: stm32: Remove rdinit from bootargs on
 stm32f429i-eval
In-Reply-To: <1500280565-26049-1-git-send-email-alexandre.torgue@st.com>
References: <1500280565-26049-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1500280565-26049-3-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rootfs is independent from the board.

Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index dcda0bb..97b1c23 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -55,7 +55,7 @@
 	compatible = "st,stm32429i-eval", "st,stm32f429";
 
 	chosen {
-		bootargs = "root=/dev/ram rdinit=/linuxrc";
+		bootargs = "root=/dev/ram";
 		stdout-path = "serial0:115200n8";
 	};
 
-- 
1.9.1
