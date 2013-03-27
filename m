From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 27 Mar 2013 12:46:56 +0900
Subject: [PATCH 1/2] ARM: shmobile: marzen: defconfig: add GPIO RCAR driver
 support
In-Reply-To: <1364356017-25890-1-git-send-email-horms+renesas@verge.net.au>
References: <1364356017-25890-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364356017-25890-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the driver added in "gpio: Renesas R-Car GPIO driver V3"

Cc: Magnus Damm <damm@opensource.se>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/marzen_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/marzen_defconfig b/arch/arm/configs/marzen_defconfig
index afb17d6..4b183d1 100644
--- a/arch/arm/configs/marzen_defconfig
+++ b/arch/arm/configs/marzen_defconfig
@@ -75,6 +75,7 @@ CONFIG_I2C_RCAR=y
 CONFIG_SPI=y
 CONFIG_SPI_SH_HSPI=y
 CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_RCAR=y
 # CONFIG_HWMON is not set
 CONFIG_THERMAL=y
 CONFIG_RCAR_THERMAL=y
-- 
1.7.10.4
