From: guodong.xu@linaro.org (Guodong Xu)
Date: Sat,  2 Apr 2016 19:47:52 +0800
Subject: [PATCH v3 2/4] arm64: defconfig: add CONFIG_SPI_SPIDEV as module
In-Reply-To: <1459597674-6834-1-git-send-email-guodong.xu@linaro.org>
References: <1459597674-6834-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <1459597674-6834-3-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add CONFIG_SPI_SPIDEV as module, for arm64.

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 32b4f2d..e4952c5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -154,6 +154,7 @@ CONFIG_I2C_RCAR=y
 CONFIG_SPI=y
 CONFIG_SPI_PL022=y
 CONFIG_SPI_QUP=y
+CONFIG_SPI_SPIDEV=m
 CONFIG_SPMI=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_PINCTRL_MSM8916=y
-- 
1.9.1
