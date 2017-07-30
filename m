From: contact@paulk.fr (Paul Kocialkowski)
Date: Sun, 30 Jul 2017 13:22:19 +0200
Subject: [PATCH 2/3] ARM: configs: Add Tegra I2S interfaces to tegra_defconfig
In-Reply-To: <20170730112220.15525-1-contact@paulk.fr>
References: <20170730112220.15525-1-contact@paulk.fr>
Message-ID: <20170730112220.15525-2-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This selects both the Tegra20 and Tegra30 I2S interfaces (that were
previously auto-selected by Kconfig but are not anymore) to
tegra_defconfig, as built-ins.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/configs/tegra_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index f0efc854b5a2..fe1275aa067e 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -202,6 +202,8 @@ CONFIG_SND_HDA_CODEC_HDMI=y
 # CONFIG_SND_USB is not set
 CONFIG_SND_SOC=y
 CONFIG_SND_SOC_TEGRA=y
+CONFIG_SND_SOC_TEGRA20_I2S=y
+CONFIG_SND_SOC_TEGRA30_I2S=y
 CONFIG_SND_SOC_TEGRA_RT5640=y
 CONFIG_SND_SOC_TEGRA_WM8753=y
 CONFIG_SND_SOC_TEGRA_WM8903=y
-- 
2.13.3
