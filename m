From: guodong.xu@linaro.org (Guodong Xu)
Date: Mon,  7 Aug 2017 22:31:59 +0800
Subject: [PATCH 4/5] arm64: defconfig: enable support for serial port
 connected device
In-Reply-To: <20170807143200.6764-1-guodong.xu@linaro.org>
References: <20170807143200.6764-1-guodong.xu@linaro.org>
Message-ID: <20170807143200.6764-5-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables these configs:

+CONFIG_SERIAL_DEV_BUS=y
+CONFIG_SERIAL_DEV_CTRL_TTYPORT=y

As example, a bluetooth device connected to UART port can be supported by
this.

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f7081056..99f7e06 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -251,6 +251,8 @@ CONFIG_SERIAL_MSM_CONSOLE=y
 CONFIG_SERIAL_XILINX_PS_UART=y
 CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
 CONFIG_SERIAL_MVEBU_UART=y
+CONFIG_SERIAL_DEV_BUS=y
+CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MUX=y
-- 
2.10.2
