From: grant.likely@linaro.org (Grant Likely)
Date: Wed,  3 Feb 2016 18:00:01 +0000
Subject: [PATCH] aarch64: Enable i2c chardev in defconfig
Message-ID: <1454522401-3729-1-git-send-email-grant.likely@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The I2C character device is commonly used, and should be enabled by
default. Add it to the defconfig.

Signed-off-by: Grant Likely <grant.likely@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d63b6e3797b6..3c26e587a264 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -147,6 +147,7 @@ CONFIG_SERIAL_XILINX_PS_UART=y
 CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
 CONFIG_VIRTIO_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
+CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_DESIGNWARE_PLATFORM=y
 CONFIG_I2C_QUP=y
 CONFIG_SPI=y
-- 
2.5.0
