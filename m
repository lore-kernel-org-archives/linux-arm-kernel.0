From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 12 Aug 2016 18:33:00 +0800
Subject: [PATCH] arm64: defconfig: enable BERLIN_BG4CT pinctrl support
Message-ID: <1470997980-477-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables pinctrl support required to boot Marvell BG4CT
boards.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0555b7c..52fff49 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -195,6 +195,7 @@ CONFIG_SPI_QUP=y
 CONFIG_SPI_SPIDEV=m
 CONFIG_SPI_S3C64XX=y
 CONFIG_SPMI=y
+CONFIG_PINCTRL_BERLIN_BG4CT=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_PINCTRL_MAX77620=y
 CONFIG_PINCTRL_MSM8916=y
-- 
2.8.1
