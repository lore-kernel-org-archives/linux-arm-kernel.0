From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Fri, 10 Apr 2015 23:36:02 +0200
Subject: [PATCH 7/9] ARM: tegra: enable HDA in defconfig
In-Reply-To: <cover.1428700856.git.marcel.ziswiler@toradex.com>
References: <cover.1428700856.git.marcel.ziswiler@toradex.com>
Message-ID: <16307b8af5a65c8ba5a2b9cb640b4718142adbca.1428700856.git.marcel.ziswiler@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---
 arch/arm/configs/tegra_defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 18047c4..cdf9abb 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -196,6 +196,14 @@ CONFIG_SOUND=y
 CONFIG_SND=y
 # CONFIG_SND_SUPPORT_OLD_API is not set
 # CONFIG_SND_DRIVERS is not set
+CONFIG_SND_HDA=y
+CONFIG_SND_HDA_TEGRA=y
+CONFIG_SND_HDA_INPUT_BEEP=y
+CONFIG_SND_HDA_INPUT_JACK=y
+CONFIG_SND_HDA_PATCH_LOADER=y
+CONFIG_SND_HDA_CODEC_REALTEK=y
+CONFIG_SND_HDA_CODEC_HDMI=y
+CONFIG_SND_HDA_GENERIC=y
 # CONFIG_SND_ARM is not set
 # CONFIG_SND_SPI is not set
 # CONFIG_SND_USB is not set
-- 
1.9.3
