From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 12 Jun 2013 11:37:16 -0600
Subject: [PATCH 3/3] ARM: tegra: enable RT5640 sound driver in defconfig
In-Reply-To: <1371058636-25244-1-git-send-email-swarren@wwwdotorg.org>
References: <1371058636-25244-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1371058636-25244-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Enable the ASoC machine driver that is required for audio on Dalmore
and Beaver.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/configs/tegra_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 44e00ed..2d9a483 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -179,6 +179,7 @@ CONFIG_SND=y
 # CONFIG_SND_USB is not set
 CONFIG_SND_SOC=y
 CONFIG_SND_SOC_TEGRA=y
+CONFIG_SND_SOC_TEGRA_RT5640=y
 CONFIG_SND_SOC_TEGRA_WM8753=y
 CONFIG_SND_SOC_TEGRA_WM8903=y
 CONFIG_SND_SOC_TEGRA_TRIMSLICE=y
-- 
1.8.1.5
