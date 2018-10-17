From: open.sudheer@gmail.com (sudheer.v)
Date: Wed, 17 Oct 2018 09:40:59 +0530
Subject: [[PATCH] 2/9] Defconfig-changes-for-DMA-UART-of-AST2500
In-Reply-To: <1539749466-3912-1-git-send-email-open.sudheer@gmail.com>
References: <1539749466-3912-1-git-send-email-open.sudheer@gmail.com>
Message-ID: <1539749466-3912-3-git-send-email-open.sudheer@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: sudheer.v <open.sudheer@gmail.com>
---
 arch/arm/configs/aspeed_g5_defconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index b7f8fa1..25813b5 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -132,8 +132,8 @@ CONFIG_KEYBOARD_GPIO_POLLED=y
 CONFIG_SERIAL_8250=y
 # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
 CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=6
-CONFIG_SERIAL_8250_RUNTIME_UARTS=6
+CONFIG_SERIAL_8250_NR_UARTS=1
+CONFIG_SERIAL_8250_RUNTIME_UARTS=1
 CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_ASPEED_VUART=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
@@ -211,6 +211,8 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_RTC_DRV_PCF8523=y
 CONFIG_RTC_DRV_RV8803=y
+CONFIG_DMADEVICES=y
+CONFIG_AST_UART_SDMA=y
 # CONFIG_VIRTIO_MENU is not set
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_IIO=y
-- 
1.9.1
