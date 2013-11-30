From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Sat, 30 Nov 2013 15:36:08 +0100
Subject: [PATCH 1/3] ARM: imx27: add pwm0 pingrp
Message-ID: <1385822170-98486-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
---
 arch/arm/boot/dts/imx27-pingrp.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-pingrp.h b/arch/arm/boot/dts/imx27-pingrp.h
index f3fbf5a..24df7dd7 100644
--- a/arch/arm/boot/dts/imx27-pingrp.h
+++ b/arch/arm/boot/dts/imx27-pingrp.h
@@ -88,6 +88,9 @@
 #define MX27_OWIRE1_PINGRP1 \
 	MX27_PAD_RTCK__OWIRE 0x0
 
+#define MX27_PWM_PINGRP1 \
+	MX27_PAD_PWMO__PWMO 0x0
+
 #define MX27_SDHC1_PINGRP1 \
 	MX27_PAD_SD1_CLK__SD1_CLK \
 	MX27_PAD_SD1_CMD__SD1_CMD \
-- 
1.8.3.2
