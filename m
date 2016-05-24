From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 May 2016 10:54:40 +0900
Subject: [PATCH v3 3/3] arm64: defconfig: enable Renesas R8A7796 SoC
In-Reply-To: <1464054880-25843-1-git-send-email-horms+renesas@verge.net.au>
References: <1464054880-25843-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1464054880-25843-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch enables the Renesas R8A7796 SoC in the arm64 defconfig.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2 [Simon Horman]
* Added Acked-by tag from Geert Uytterhoeven
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f70505186820..0d37fa5a59aa 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -44,6 +44,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_ARCH_SEATTLE=y
 CONFIG_ARCH_RENESAS=y
 CONFIG_ARCH_R8A7795=y
+CONFIG_ARCH_R8A7796=y
 CONFIG_ARCH_STRATIX10=y
 CONFIG_ARCH_TEGRA=y
 CONFIG_ARCH_SPRD=y
-- 
2.1.4
