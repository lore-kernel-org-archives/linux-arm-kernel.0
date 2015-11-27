From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 27 Nov 2015 10:54:58 +0900
Subject: [PATCH 1/5] arm64: defconfig: Enable GPIO of Renesas R-Car Gen3 SoC
In-Reply-To: <cover.1448588763.git.horms+renesas@verge.net.au>
References: <cover.1448588763.git.horms+renesas@verge.net.au>
Message-ID: <316d9df674e4373711943fa3de34c6d1397cac66.1448588763.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

Enable GPIO for  Renesas R-Car Gen3 SoC.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a260e3a46f01..206dfd99295c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -135,6 +135,7 @@ CONFIG_SPI_PL022=y
 CONFIG_SPI_QUP=y
 CONFIG_PINCTRL_MSM8916=y
 CONFIG_GPIO_PL061=y
+CONFIG_GPIO_RCAR=y
 CONFIG_GPIO_XGENE=y
 CONFIG_POWER_RESET_XGENE=y
 CONFIG_POWER_RESET_SYSCON=y
-- 
2.1.4
