From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 13 Oct 2011 10:57:01 -0600
Subject: [PATCH] ARM: tegra: Add sound support to tegra_defconfig
Message-ID: <1318525021-7151-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable Tegra ALSA/ASoC/sound support, including drivers for TrimSlice,
and WM8903-based platforms such as Harmony and Seaboard.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Olof, this is for squashing into your recently posted "[PATCH] ARM:
tegra: update defconfig". Please also consider that patch of yours:
Acked-by: Stephen Warren <swarren@nvidia.com>

 arch/arm/configs/tegra_defconfig |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index c41e117..1957297 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -105,6 +105,18 @@ CONFIG_SENSORS_LM90=y
 CONFIG_MFD_TPS6586X=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_TPS6586X=y
+CONFIG_SOUND=y
+CONFIG_SND=y
+# CONFIG_SND_SUPPORT_OLD_API is not set
+# CONFIG_SND_DRIVERS is not set
+# CONFIG_SND_PCI is not set
+# CONFIG_SND_ARM is not set
+# CONFIG_SND_SPI is not set
+# CONFIG_SND_USB is not set
+CONFIG_SND_SOC=y
+CONFIG_SND_SOC_TEGRA=y
+CONFIG_SND_SOC_TEGRA_WM8903=y
+CONFIG_SND_SOC_TEGRA_TRIMSLICE=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_TEGRA=y
-- 
1.7.0.4
