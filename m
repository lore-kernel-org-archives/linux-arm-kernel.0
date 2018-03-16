From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:51:49 +0100
Subject: [PATCH 1/3] ARM: shmobile: Enable RZA1 pin controller
In-Reply-To: <cover.1521206439.git.horms+renesas@verge.net.au>
References: <cover.1521206439.git.horms+renesas@verge.net.au>
Message-ID: <f90d738ef6718b35ac7267b05a2e027c90e19f4d.1521206439.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

Enable PINCTRL_RZA1 option in shmobile_defconfig

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Tested-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 578434cfd1a0..79b2b7c12264 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -120,6 +120,7 @@ CONFIG_SPI=y
 CONFIG_SPI_RSPI=y
 CONFIG_SPI_SH_MSIOF=y
 CONFIG_SPI_SH_HSPI=y
+CONFIG_PINCTRL_RZA1=y
 CONFIG_GPIO_EM=y
 CONFIG_GPIO_RCAR=y
 CONFIG_GPIO_PCF857X=y
-- 
2.11.0
