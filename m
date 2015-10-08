From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Thu,  8 Oct 2015 15:31:19 +0200
Subject: [PATCH v4 8/8] ARM: multi_v7_defconfig: Add rockchip audio support
In-Reply-To: <1444311079-2892-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1444311079-2892-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <1444311079-2892-9-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable support for audio device found on rockchip boards.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm/configs/multi_v7_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 03deb7f..febce7e 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -478,6 +478,10 @@ CONFIG_SND_USB_AUDIO=y
 CONFIG_SND_SOC=m
 CONFIG_SND_ATMEL_SOC=m
 CONFIG_SND_ATMEL_SOC_WM8904=m
+CONFIG_SND_SOC_ROCKCHIP=m
+CONFIG_SND_SOC_ROCKCHIP_SPDIF=m
+CONFIG_SND_SOC_ROCKCHIP_MAX98090=m
+CONFIG_SND_SOC_ROCKCHIP_RT5645=m
 CONFIG_SND_SOC_SH4_FSI=m
 CONFIG_SND_SOC_RCAR=m
 CONFIG_SND_SOC_RSRC_CARD=m
@@ -489,6 +493,7 @@ CONFIG_SND_SOC_TEGRA_TRIMSLICE=m
 CONFIG_SND_SOC_TEGRA_ALC5632=m
 CONFIG_SND_SOC_TEGRA_MAX98090=m
 CONFIG_SND_SOC_AK4642=m
+CONFIG_SND_SOC_SPDIF=m
 CONFIG_SND_SOC_WM8978=m
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
-- 
2.6.1
