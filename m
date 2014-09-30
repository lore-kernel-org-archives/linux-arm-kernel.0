From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 30 Sep 2014 10:00:36 +0800
Subject: [PATCH 3/6] ARM: imx_v6_v7_defconfig: enable USB audio at host mode
In-Reply-To: <1412042439-13977-1-git-send-email-peter.chen@freescale.com>
References: <1412042439-13977-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1412042439-13977-4-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is built as modules

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 8e92749..9598df4 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -212,6 +212,7 @@ CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
 CONFIG_SOUND=y
 CONFIG_SND=y
+CONFIG_SND_USB_AUDIO=m
 CONFIG_SND_SOC=y
 CONFIG_SND_IMX_SOC=y
 CONFIG_SND_SOC_PHYCORE_AC97=y
-- 
1.7.9.5
