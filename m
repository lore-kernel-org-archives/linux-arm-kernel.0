From: john.garry@huawei.com (John Garry)
Date: Fri, 19 Oct 2018 00:17:07 +0800
Subject: [PATCH] arm64: defconfig: Enable some IPMI configs
Message-ID: <1539879427-11816-1-git-send-email-john.garry@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm64 port now runs on servers which use IPMI. This patch enables
relevant core configs to save manually enabling them when testing
mainline.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index db8d364..fe8c097 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -297,6 +297,9 @@ CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
 CONFIG_SERIAL_MVEBU_UART=y
 CONFIG_SERIAL_DEV_BUS=y
 CONFIG_VIRTIO_CONSOLE=y
+CONFIG_IPMI_HANDLER=y
+CONFIG_IPMI_DEVICE_INTERFACE=y
+CONFIG_IPMI_SI=y
 CONFIG_TCG_TPM=y
 CONFIG_TCG_TIS_I2C_INFINEON=y
 CONFIG_I2C_CHARDEV=y
-- 
1.9.1
