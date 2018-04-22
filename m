From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 22 Apr 2018 12:38:05 +0200
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: enable the Meson PWM controller
In-Reply-To: <20180422103805.1324-1-martin.blumenstingl@googlemail.com>
References: <20180422103805.1324-1-martin.blumenstingl@googlemail.com>
Message-ID: <20180422103805.1324-3-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the Amlogic Meson PWM controller. It is used for a dimmable
LED on some devices. Additionally some devices use it to generate the
32.768 kHz (low power oscillator) clock.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 19e60d562e5f..e8e4341e96c7 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -948,6 +948,7 @@ CONFIG_PWM_ATMEL=m
 CONFIG_PWM_ATMEL_HLCDC_PWM=m
 CONFIG_PWM_ATMEL_TCB=m
 CONFIG_PWM_FSL_FTM=m
+CONFIG_PWM_MESON=m
 CONFIG_PWM_RCAR=m
 CONFIG_PWM_RENESAS_TPU=y
 CONFIG_PWM_ROCKCHIP=m
-- 
2.17.0
