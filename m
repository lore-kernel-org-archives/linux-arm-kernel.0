From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Fri,  8 Jan 2016 13:16:46 +0100
Subject: [PATCH] ARM: multi_v7_defconfig: Add rockchip audio support
Message-ID: <1452255406-2439-1-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the rockchip SPDIF driver landed for 4.4 and the required clock
patches to make it work properly are scheduled for the 4.5 merge window
it seems time to support for audio device found on rockchip boards in
the defconfig as well.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

---

 arch/arm/configs/multi_v7_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index f6e104d..089b4da 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -548,6 +548,10 @@ CONFIG_SND_SOC=m
 CONFIG_SND_ATMEL_SOC=m
 CONFIG_SND_ATMEL_SOC_WM8904=m
 CONFIG_SND_SOC_FSL_SAI=m
+CONFIG_SND_SOC_ROCKCHIP=m
+CONFIG_SND_SOC_ROCKCHIP_SPDIF=m
+CONFIG_SND_SOC_ROCKCHIP_MAX98090=m
+CONFIG_SND_SOC_ROCKCHIP_RT5645=m
 CONFIG_SND_SOC_SH4_FSI=m
 CONFIG_SND_SOC_RCAR=m
 CONFIG_SND_SOC_RSRC_CARD=m
@@ -564,6 +568,7 @@ CONFIG_SND_SOC_TEGRA_ALC5632=m
 CONFIG_SND_SOC_TEGRA_MAX98090=m
 CONFIG_SND_SOC_AK4642=m
 CONFIG_SND_SOC_SGTL5000=m
+CONFIG_SND_SOC_SPDIF=m
 CONFIG_SND_SOC_WM8978=m
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
-- 
2.7.0.rc3
