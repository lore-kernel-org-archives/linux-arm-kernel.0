From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Sun, 19 Jun 2016 03:00:02 +0200
Subject: [PATCH v4 3/3] ARM: tegra: enable sgtl5000 audio
In-Reply-To: <1466298002-12576-1-git-send-email-marcel.ziswiler@toradex.com>
References: <1466298002-12576-1-git-send-email-marcel.ziswiler@toradex.com>
Message-ID: <1466298002-12576-4-git-send-email-marcel.ziswiler@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NVIDIA Tegra 3 aka T30 based Apalis T30 and Colibri T30 as well as
the new Tegra K1 aka TK1 based Apalis TK1 modules contain a Freescale
SGTL5000 analogue audio codec.

Signed-off-by: Marcel Ziswiler <marcel@ziswiler.com>
Reviewed-by: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm/configs/tegra_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index bc80a47..c1d0f91 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -216,6 +216,7 @@ CONFIG_SND_SOC_TEGRA_WM9712=y
 CONFIG_SND_SOC_TEGRA_TRIMSLICE=y
 CONFIG_SND_SOC_TEGRA_ALC5632=y
 CONFIG_SND_SOC_TEGRA_MAX98090=y
+CONFIG_SND_SOC_TEGRA_SGTL5000=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_TEGRA=y
-- 
2.5.5
