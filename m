From: d.lavnikevich@sam-solutions.com (Dmitry Lavnikevich)
Date: Wed, 22 Oct 2014 12:11:17 +0300
Subject: [PATCH v4 RESEND 3/3] ARM: imx_v6_v7_defconfig: enable tlv320aic3x
 audio codec by default
In-Reply-To: <1413968914-13689-1-git-send-email-d.lavnikevich@sam-solutions.com>
References: <1413968914-13689-1-git-send-email-d.lavnikevich@sam-solutions.com>
Message-ID: <1413969077-14276-1-git-send-email-d.lavnikevich@sam-solutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Used on Phytec PBAB01 board.

Signed-off-by: Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 8fca6e276b69..cac07d67b933 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -210,6 +210,7 @@ CONFIG_SND_SOC_IMX_WM8962=y
 CONFIG_SND_SOC_IMX_SGTL5000=y
 CONFIG_SND_SOC_IMX_SPDIF=y
 CONFIG_SND_SOC_IMX_MC13783=y
+CONFIG_SND_SOC_TLV320AIC3X=y
 CONFIG_SND_SIMPLE_CARD=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
-- 
2.1.2
