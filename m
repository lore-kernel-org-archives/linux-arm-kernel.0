From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Fri, 30 Sep 2016 16:25:09 +0200
Subject: [PATCH 6/6] ARM: dts: stm32f429: Add QSPI clock
In-Reply-To: <1475245509-6487-1-git-send-email-gabriel.fernandez@st.com>
References: <1475245509-6487-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1475245509-6487-7-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch adds the QSPI clock for stm32f469 discovery board.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 arch/arm/boot/dts/stm32f469-disco.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
index cb55ac8..80aecc0 100644
--- a/arch/arm/boot/dts/stm32f469-disco.dts
+++ b/arch/arm/boot/dts/stm32f469-disco.dts
@@ -66,6 +66,10 @@
 	};
 };
 
+&rcc {
+	compatible = "st,stm32f46xx-rcc", "st,stm32-rcc";
+};
+
 &clk_hse {
 	clock-frequency = <8000000>;
 };
-- 
1.9.1
