From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 11 Jun 2017 12:03:42 +0200
Subject: [PATCH 2/3] ARM: multi_v7_defconfig: enable the Meson PWM controller
In-Reply-To: <20170611100343.25868-1-martin.blumenstingl@googlemail.com>
References: <20170611100343.25868-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170611100343.25868-3-martin.blumenstingl@googlemail.com>
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
index 49f038dcdd7c..abbe288a5134 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -870,6 +870,7 @@ CONFIG_PWM_ATMEL=m
 CONFIG_PWM_ATMEL_HLCDC_PWM=m
 CONFIG_PWM_ATMEL_TCB=m
 CONFIG_PWM_FSL_FTM=m
+CONFIG_PWM_MESON=y
 CONFIG_PWM_RENESAS_TPU=y
 CONFIG_PWM_ROCKCHIP=m
 CONFIG_PWM_SAMSUNG=m
-- 
2.13.1
