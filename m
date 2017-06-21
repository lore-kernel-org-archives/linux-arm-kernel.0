From: zhi.mao@mediatek.com (Zhi Mao)
Date: Wed, 21 Jun 2017 16:11:09 +0800
Subject: [PATCH RESEND 1/4] pwm: kconfig: modify mediatek information
In-Reply-To: <1498032672-7172-1-git-send-email-zhi.mao@mediatek.com>
References: <1498032672-7172-1-git-send-email-zhi.mao@mediatek.com>
Message-ID: <1498032672-7172-2-git-send-email-zhi.mao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

modify mediatek information

Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
---
 drivers/pwm/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 313c107..45cdf2a 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -300,7 +300,7 @@ config PWM_MEDIATEK
 	  Generic PWM framework driver for Mediatek ARM SoC.
 
 	  To compile this driver as a module, choose M here: the module
-	  will be called pwm-mxs.
+	  will be called pwm-mediatek.
 
 config PWM_MXS
 	tristate "Freescale MXS PWM support"
-- 
1.7.9.5
