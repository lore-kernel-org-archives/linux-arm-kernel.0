From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 27 Oct 2015 10:42:06 +0900
Subject: [PATCH v2 2/2] arm64: defconfig: Enable GPIO of Renesas R-Car Gen3 SoC
In-Reply-To: <1445910126-14097-1-git-send-email-horms+renesas@verge.net.au>
References: <1445910126-14097-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1445910126-14097-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

Enable GPIO for  Renesas R-Car Gen3 SoC.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[horms: only enable GPIO_RCAR]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index dccc685b58ae..d9946384f102 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -125,6 +125,7 @@ CONFIG_SPI=y
 CONFIG_SPI_PL022=y
 CONFIG_PINCTRL_MSM8916=y
 CONFIG_GPIO_PL061=y
+CONFIG_GPIO_RCAR=y
 CONFIG_GPIO_XGENE=y
 CONFIG_POWER_RESET_XGENE=y
 CONFIG_POWER_RESET_SYSCON=y
-- 
2.1.4
