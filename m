From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 23 Mar 2016 11:49:53 -0700
Subject: [PATCH] arm64: defconfig: enable basic boot for Amlogic meson
Message-ID: <1458758993-14467-1-git-send-email-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enables basic arch and serial console support for Amlogic meson family
SoCs.

Tested with Amlogic P200 and Hardkernel ODROID-C2 boards.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f70505186820..71c9d21c06ca 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -38,6 +38,7 @@ CONFIG_ARCH_EXYNOS=y
 CONFIG_ARCH_LAYERSCAPE=y
 CONFIG_ARCH_HISI=y
 CONFIG_ARCH_MEDIATEK=y
+CONFIG_ARCH_MESON=y
 CONFIG_ARCH_MVEBU=y
 CONFIG_ARCH_QCOM=y
 CONFIG_ARCH_ROCKCHIP=y
@@ -137,6 +138,8 @@ CONFIG_SERIAL_TEGRA=y
 CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_SH_SCI_NR_UARTS=11
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
+CONFIG_SERIAL_MESON=y
+CONFIG_SERIAL_MESON_CONSOLE=y
 CONFIG_SERIAL_MSM=y
 CONFIG_SERIAL_MSM_CONSOLE=y
 CONFIG_SERIAL_XILINX_PS_UART=y
-- 
2.7.4
