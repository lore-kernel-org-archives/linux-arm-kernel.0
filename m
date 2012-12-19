From: marex@denx.de (Marek Vasut)
Date: Wed, 19 Dec 2012 18:33:00 +0100
Subject: [PATCH 2/8] arm: mxs: Enable MTD block access
In-Reply-To: <1355938386-14582-1-git-send-email-marex@denx.de>
References: <1355938386-14582-1-git-send-email-marex@denx.de>
Message-ID: <1355938386-14582-3-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using the SPI flashes, it can be convenient to use MTD block
emulation layer to access the flash. Enable the MTD block access.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/configs/mxs_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index fdb92e1..8b4b6c9 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -52,6 +52,7 @@ CONFIG_DEVTMPFS=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
 CONFIG_MTD_DATAFLASH=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_GPMI_NAND=y
-- 
1.7.10.4
