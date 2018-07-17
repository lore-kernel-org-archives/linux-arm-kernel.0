From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Tue, 17 Jul 2018 18:06:07 +0200
Subject: [PATCH 2/5] arm64: defconfig: Enable Infineon TPM security chip.
In-Reply-To: <20180717160610.26501-1-enric.balletbo@collabora.com>
References: <20180717160610.26501-1-enric.balletbo@collabora.com>
Message-ID: <20180717160610.26501-2-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some Chromebooks (like the Samsung Chromebook Plus) have a TPM security
chip that is compliant with the TCG TIS 1.2 TPM specification and
Infineon's I2C Protocol Stack. So, add support in the defconfig.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4917641060b1..e530d6fc34b2 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -294,6 +294,8 @@ CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
 CONFIG_SERIAL_MVEBU_UART=y
 CONFIG_SERIAL_DEV_BUS=y
 CONFIG_VIRTIO_CONSOLE=y
+CONFIG_TCG_TPM=y
+CONFIG_TCG_TIS_I2C_INFINEON=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MUX=y
 CONFIG_I2C_MUX_PCA954x=y
-- 
2.18.0
