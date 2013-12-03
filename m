From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Tue,  3 Dec 2013 08:50:50 +0100
Subject: [PATCHv2 1/3] ARM: imx27: add pwm pingrp
Message-ID: <1386057052-9978-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
---
Changelog:
v2:
 * rename mail subject : pwm0 -> pwm

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
