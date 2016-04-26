From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 26 Apr 2016 12:04:13 +0200
Subject: [PATCH] ARM: dts: at91: fix typo in sama5d2 PIN_PD24 description
Message-ID: <1461665075-9636-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Florian Vallee <fvallee@eukrea.fr>

Fix a typo on PIN_PD24 for UTXD2 and FLEXCOM4_IO3 which were
wrongly linked to PIN_PD23).

Signed-off-by: Florian Vallee <fvallee@eukrea.fr>
Fixes: 7f16cb676c00 ("ARM: at91/dt: add sama5d2 pinmux")
Cc: stable at vger.kernel.org # v4.4+
[nicolas.ferre at atmel.com: add commit message, changed subject]
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
Hi,

I'll queue this patch in at91-4.7-dt branch.

thanks, bye.

 arch/arm/boot/dts/sama5d2-pinfunc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d2-pinfunc.h b/arch/arm/boot/dts/sama5d2-pinfunc.h
index b0c912feaa2f..8a394f336003 100644
--- a/arch/arm/boot/dts/sama5d2-pinfunc.h
+++ b/arch/arm/boot/dts/sama5d2-pinfunc.h
@@ -837,8 +837,8 @@
 #define PIN_PD23__ISC_FIELD		PINMUX_PIN(PIN_PD23, 6, 4)
 #define PIN_PD24			120
 #define PIN_PD24__GPIO			PINMUX_PIN(PIN_PD24, 0, 0)
-#define PIN_PD24__UTXD2			PINMUX_PIN(PIN_PD23, 1, 2)
-#define PIN_PD24__FLEXCOM4_IO3		PINMUX_PIN(PIN_PD23, 3, 3)
+#define PIN_PD24__UTXD2			PINMUX_PIN(PIN_PD24, 1, 2)
+#define PIN_PD24__FLEXCOM4_IO3		PINMUX_PIN(PIN_PD24, 3, 3)
 #define PIN_PD25			121
 #define PIN_PD25__GPIO			PINMUX_PIN(PIN_PD25, 0, 0)
 #define PIN_PD25__SPI1_SPCK		PINMUX_PIN(PIN_PD25, 1, 3)
-- 
2.1.3
