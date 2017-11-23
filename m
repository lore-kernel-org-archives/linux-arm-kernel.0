From: vigneshr@ti.com (Vignesh R)
Date: Thu, 23 Nov 2017 13:21:54 +0530
Subject: [PATCH 6/6] ARM: configs: keystone_defconfig: Enable few peripheral
 drivers
In-Reply-To: <20171123075154.3938-1-vigneshr@ti.com>
References: <20171123075154.3938-1-vigneshr@ti.com>
Message-ID: <20171123075154.3938-7-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable drivers for QSPI, LEDS, gpio-decoder that are present on 66AK2G EVM
and 66AK2G ICE boards.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/configs/keystone_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index f710c192b33a..2536c231eea1 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -228,3 +228,10 @@ CONFIG_CRYPTO_DES=y
 CONFIG_CRYPTO_ANSI_CPRNG=y
 CONFIG_CRYPTO_USER_API_HASH=y
 CONFIG_CRYPTO_USER_API_SKCIPHER=y
+CONFIG_SPI_CADENCE_QUADSPI=y
+CONFIG_INPUT_MISC=y
+CONFIG_INPUT_EVDEV=m
+CONFIG_INPUT_GPIO_DECODER=m
+CONFIG_GPIO_PCA953X=m
+CONFIG_LEDS_TRIGGER_ACTIVITY=y
+CONFIG_LEDS_TRIGGER_CPU=y
-- 
2.15.0
