From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 15 Oct 2015 15:24:02 +0900
Subject: [PATCH v11 7/8] arm64: defconfig: renesas: Enable Renesas r8a7795 SoC
In-Reply-To: <1444890243-6978-1-git-send-email-horms+renesas@verge.net.au>
References: <1444890243-6978-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1444890243-6978-8-git-send-email-horms+renesas@verge.net.au>
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
Changes since v10:
- None

Changes since V9: (Magnus Damm <damm+renesas@opensource.se>)
- None

Changes since V8: (Magnus Damm <damm+renesas@opensource.se>)
- Added Acked-by from Geert

Changes since V7: (Magnus Damm <damm+renesas@opensource.se>)
- Updated changelog
- Use CONFIG_RENESAS and CONFIG_R8A7795

Based on:
 [PATCH 19/25] arm64: defconfig: renesas: Enable Renesas R-Car Gen3 SoC
 [PATCH 20/25] arm64: defconfig: renesas: enable SCIF
---
 arch/arm64/configs/defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 34d71dd86781..dccc685b58ae 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -39,6 +39,8 @@ CONFIG_ARCH_HISI=y
 CONFIG_ARCH_MEDIATEK=y
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_ARCH_SEATTLE=y
+CONFIG_ARCH_RENESAS=y
+CONFIG_ARCH_R8A7795=y
 CONFIG_ARCH_TEGRA=y
 CONFIG_ARCH_TEGRA_132_SOC=y
 CONFIG_ARCH_QCOM=y
@@ -109,6 +111,9 @@ CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_8250_MT6577=y
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
+CONFIG_SERIAL_SH_SCI=y
+CONFIG_SERIAL_SH_SCI_NR_UARTS=11
+CONFIG_SERIAL_SH_SCI_CONSOLE=y
 CONFIG_SERIAL_MSM=y
 CONFIG_SERIAL_MSM_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
-- 
2.1.4
