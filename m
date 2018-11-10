From: aisheng.dong@nxp.com (A.s. Dong)
Date: Sat, 10 Nov 2018 15:48:26 +0000
Subject: [PATCH V4 5/5] defconfig: arm64: add imx8qxp support
In-Reply-To: <1541864596-15958-1-git-send-email-aisheng.dong@nxp.com>
References: <1541864596-15958-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1541864596-15958-6-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 arch/arm64/configs/defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index db8d364..7e07505 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -45,6 +45,8 @@ CONFIG_ARCH_HISI=y
 CONFIG_ARCH_MEDIATEK=y
 CONFIG_ARCH_MESON=y
 CONFIG_ARCH_MVEBU=y
+CONFIG_ARCH_MXC=y
+CONFIG_SOC_IMX8QXP=y
 CONFIG_ARCH_QCOM=y
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_ARCH_SEATTLE=y
@@ -219,6 +221,7 @@ CONFIG_NET_XGENE=y
 CONFIG_ATL1C=m
 CONFIG_MACB=y
 CONFIG_THUNDER_NIC_PF=y
+CONFIG_FEC=y
 CONFIG_HIX5HD2_GMAC=y
 CONFIG_HNS_DSAF=y
 CONFIG_HNS_ENET=y
@@ -294,6 +297,8 @@ CONFIG_SERIAL_MSM=y
 CONFIG_SERIAL_MSM_CONSOLE=y
 CONFIG_SERIAL_XILINX_PS_UART=y
 CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
+CONFIG_SERIAL_FSL_LPUART=y
+CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
 CONFIG_SERIAL_MVEBU_UART=y
 CONFIG_SERIAL_DEV_BUS=y
 CONFIG_VIRTIO_CONSOLE=y
@@ -514,6 +519,7 @@ CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_OF_ARASAN=y
 CONFIG_MMC_SDHCI_OF_ESDHC=y
 CONFIG_MMC_SDHCI_CADENCE=y
+CONFIG_MMC_SDHCI_ESDHC_IMX=y
 CONFIG_MMC_SDHCI_TEGRA=y
 CONFIG_MMC_SDHCI_F_SDH30=y
 CONFIG_MMC_MESON_GX=y
-- 
2.7.4
