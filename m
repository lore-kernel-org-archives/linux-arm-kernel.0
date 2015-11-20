From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 19 Nov 2015 17:06:03 -0800
Subject: [PATCH] arm64: defconfig: renesas: Enable Renesas r8a7795 SoC
In-Reply-To: <cover.1447980456.git.horms+renesas@verge.net.au>
References: <cover.1447980456.git.horms+renesas@verge.net.au>
Message-ID: <727e8d0126e3ecafce3ebc43eaa5a7d61af3bef0.1447980456.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch enables the Renesas R-Car H3 SoC together with the
SCIF driver in the arm64 defconfig.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/configs/defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index bdd7aa358d2a..a260e3a46f01 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -39,6 +39,8 @@ CONFIG_ARCH_HISI=y
 CONFIG_ARCH_MEDIATEK=y
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_ARCH_SEATTLE=y
+CONFIG_ARCH_RENESAS=y
+CONFIG_ARCH_R8A7795=y
 CONFIG_ARCH_STRATIX10=y
 CONFIG_ARCH_TEGRA=y
 CONFIG_ARCH_TEGRA_132_SOC=y
@@ -116,6 +118,9 @@ CONFIG_SERIAL_SAMSUNG=y
 CONFIG_SERIAL_SAMSUNG_UARTS_4=y
 CONFIG_SERIAL_SAMSUNG_UARTS=4
 CONFIG_SERIAL_SAMSUNG_CONSOLE=y
+CONFIG_SERIAL_SH_SCI=y
+CONFIG_SERIAL_SH_SCI_NR_UARTS=11
+CONFIG_SERIAL_SH_SCI_CONSOLE=y
 CONFIG_SERIAL_MSM=y
 CONFIG_SERIAL_MSM_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
-- 
2.1.4
