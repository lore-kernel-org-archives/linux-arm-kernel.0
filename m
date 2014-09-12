From: d.lavnikevich@sam-solutions.com (Dmitry Lavnikevich)
Date: Fri, 12 Sep 2014 19:04:31 +0300
Subject: [PATCH v2 3/4] ARM: imx_v6_v7_defconfig: enable tlv320aic3x and
 simple-audio-card by default
In-Reply-To: <1410537872-17274-1-git-send-email-d.lavnikevich@sam-solutions.com>
References: <1410356809-26179-1-git-send-email-d.lavnikevich@sam-solutions.com>
 <1410537872-17274-1-git-send-email-d.lavnikevich@sam-solutions.com>
Message-ID: <1410537872-17274-4-git-send-email-d.lavnikevich@sam-solutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Used on Phytec PBAB01 board.

Signed-off-by: Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 16cfec4385c8..b344290c537b 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -213,6 +213,8 @@ CONFIG_SND_SOC_IMX_WM8962=y
 CONFIG_SND_SOC_IMX_SGTL5000=y
 CONFIG_SND_SOC_IMX_SPDIF=y
 CONFIG_SND_SOC_IMX_MC13783=y
+CONFIG_SND_SOC_TLV320AIC3X=y
+CONFIG_SND_SIMPLE_CARD=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_MXC=y
-- 
2.1.0
