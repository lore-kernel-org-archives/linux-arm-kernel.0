From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Fri, 14 Oct 2016 11:18:19 +0200
Subject: [PATCH v2 6/6] ARM: dts: stm32f429: Add QSPI clock
In-Reply-To: <1476436699-21879-1-git-send-email-gabriel.fernandez@st.com>
References: <1476436699-21879-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1476436699-21879-7-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch adds the QSPI clock for stm32f469 discovery board.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 arch/arm/boot/dts/stm32f469-disco.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
index e911af8..4052023 100644
--- a/arch/arm/boot/dts/stm32f469-disco.dts
+++ b/arch/arm/boot/dts/stm32f469-disco.dts
@@ -66,6 +66,10 @@
 	};
 };
 
+&rcc {
+	compatible = "st,stm32f469-rcc", "st,stm32-rcc";
+};
+
 &clk_hse {
 	clock-frequency = <8000000>;
 };
-- 
1.9.1
