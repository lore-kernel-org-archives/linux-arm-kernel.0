From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 15:03:35 +0900
Subject: [PATCH 2/7] ARM: shmobile: lager: fixup I2C device on defconfig
In-Reply-To: <cover.1387854925.git.horms+renesas@verge.net.au>
References: <cover.1387854925.git.horms+renesas@verge.net.au>
Message-ID: <d0523925902cf363fc7b217c9873517e98093e32.1387854925.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

R-Car H2 needs I2C_CAR, not I2C_SH_MOBILE

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/lager_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/lager_defconfig b/arch/arm/configs/lager_defconfig
index 064b7cc..d97ac5e 100644
--- a/arch/arm/configs/lager_defconfig
+++ b/arch/arm/configs/lager_defconfig
@@ -80,7 +80,7 @@ CONFIG_SERIAL_SH_SCI_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
 CONFIG_I2C_GPIO=y
-CONFIG_I2C_SH_MOBILE=y
+CONFIG_I2C_RCAR=y
 CONFIG_GPIO_SH_PFC=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_RCAR=y
-- 
1.8.4
