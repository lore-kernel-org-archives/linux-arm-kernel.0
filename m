From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 31 May 2010 10:49:53 +0200
Subject: [PATCH 1/2] i.MX ssi: MX31ads sound support should depend on
	MACH_MX31ADS
In-Reply-To: <1275295794-3168-1-git-send-email-s.hauer@pengutronix.de>
References: <1275295794-3168-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1275295794-3168-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/imx/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/imx/Kconfig b/sound/soc/imx/Kconfig
index eba9b9d..11b4bcc 100644
--- a/sound/soc/imx/Kconfig
+++ b/sound/soc/imx/Kconfig
@@ -13,7 +13,7 @@ config SND_MXC_SOC_SSI
 
 config SND_MXC_SOC_WM1133_EV1
 	tristate "Audio on the the i.MX31ADS with WM1133-EV1 fitted"
-	depends on SND_IMX_SOC && EXPERIMENTAL
+	depends on SND_IMX_SOC && MACH_MX31ADS && EXPERIMENTAL
 	select SND_SOC_WM8350
 	select SND_MXC_SOC_SSI
 	help
-- 
1.7.1
