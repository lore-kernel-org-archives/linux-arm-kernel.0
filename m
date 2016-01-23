From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 23 Jan 2016 18:04:12 +0900
Subject: [PATCH] arm64: defconfig: enable UniPhier I2C (FIFO-builtin) driver
Message-ID: <1453539852-18020-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver is used by the UniPhier PH1-LD10 SoC
(arch/arm64/boot/dts/socionext/uniphier-ph1-ld10.dtsi).

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 18ca9fb..2e2e4c1 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -136,6 +136,7 @@ CONFIG_VIRTIO_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
 CONFIG_I2C_QUP=y
+CONFIG_I2C_UNIPHIER_F=y
 CONFIG_I2C_RCAR=y
 CONFIG_SPI=y
 CONFIG_SPI_PL022=y
-- 
1.9.1
