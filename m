From: wens@csie.org (Chen-Yu Tsai)
Date: Sat,  6 Feb 2016 23:53:45 +0800
Subject: [PATCH 2/6] ARM: sunxi_defconfig: Enable A10 audio codec driver
In-Reply-To: <1454774029-10469-1-git-send-email-wens@csie.org>
References: <1454774029-10469-1-git-send-email-wens@csie.org>
Message-ID: <1454774029-10469-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A10 audio codec driver supports the on-chip audio codec found on
Allwinner A10, A10s, A13, A20 SoCs.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/configs/sunxi_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 7d2e7bf81a47..efa12c88fe1c 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -100,6 +100,10 @@ CONFIG_FB=y
 CONFIG_FB_SIMPLE=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_SOC=y
+CONFIG_SND_SUN4I_CODEC=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_HCD_PLATFORM=y
-- 
2.7.0
