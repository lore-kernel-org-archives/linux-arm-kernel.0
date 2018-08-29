From: codrin.ciubotariu@microchip.com (Codrin Ciubotariu)
Date: Wed, 29 Aug 2018 19:47:54 +0300
Subject: [PATCH 1/2] ARM: configs: at91: Add I2S driver to sama5
Message-ID: <20180829164755.4690-1-codrin.ciubotariu@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add I2S CONFIG_SND_ATMEL_SOC_I2S to sama5_defconfig.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 arch/arm/configs/sama5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 2080025556b5..b6d73055a854 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -167,6 +167,7 @@ CONFIG_SND_ATMEL_SOC_WM8904=y
 # CONFIG_HID_GENERIC is not set
 CONFIG_SND_ATMEL_SOC_PDMIC=y
 CONFIG_SND_ATMEL_SOC_TSE850_PCM5142=m
+CONFIG_SND_ATMEL_SOC_I2S=y
 CONFIG_USB=y
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 CONFIG_USB_EHCI_HCD=y
-- 
2.17.1
