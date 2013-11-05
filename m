From: denis@eukrea.com (Denis Carikli)
Date: Tue,  5 Nov 2013 15:39:13 +0100
Subject: [PATCHv11][ 6/7] ARM i.MX25: build in pinctrl support.
In-Reply-To: <1383662354-22417-1-git-send-email-denis@eukrea.com>
References: <1383662354-22417-1-git-send-email-denis@eukrea.com>
Message-ID: <1383662354-22417-6-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree at vger.kernel.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v9->v10:
- Splitted to make the automatic enabling of the functionality separate.
---
 arch/arm/mach-imx/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 2b90984..4df7305 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -102,6 +102,8 @@ config SOC_IMX25
 	select COMMON_CLK
 	select CPU_ARM926T
 	select MXC_AVIC
+	select PINCTRL
+	select PINCTRL_IMX25
 
 config SOC_IMX27
 	bool
-- 
1.7.9.5
