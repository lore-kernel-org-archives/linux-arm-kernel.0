From: peng.fan@nxp.com (Peng Fan)
Date: Thu, 28 Dec 2017 17:34:19 +0800
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Enable OP-TEE
In-Reply-To: <1514453660-15373-1-git-send-email-peng.fan@nxp.com>
References: <1514453660-15373-1-git-send-email-peng.fan@nxp.com>
Message-ID: <1514453660-15373-2-git-send-email-peng.fan@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable OP-TEE for multi_v7_defconfig

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Olof Johansson <olof@lixom.net>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Rask Ingemann Lambertsen <rask@formelder.dk>
Cc: Valentin Rothberg <valentinrothberg@gmail.com>
Cc: Andy Gross <andy.gross@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Dong Aisheng <aisheng.dong@nxp.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 085c7cd4ecdf..91679b507796 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -863,6 +863,8 @@ CONFIG_PHY_TEGRA_XUSB=y
 CONFIG_OMAP_USB2=y
 CONFIG_TI_PIPE3=y
 CONFIG_NVMEM_SUNXI_SID=y
+CONFIG_TEE=y
+CONFIG_OPTEE=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
 CONFIG_BCM47XX_NVRAM=y
 CONFIG_BCM47XX_SPROM=y
-- 
2.14.1
