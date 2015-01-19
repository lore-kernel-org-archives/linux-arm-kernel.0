From: tony@atomide.com (Tony Lindgren)
Date: Mon, 19 Jan 2015 10:15:57 -0800
Subject: [PATCH 2/3] ARM: omap2plus_defconfig: Enable pcf857x
In-Reply-To: <1421691358-14661-1-git-send-email-tony@atomide.com>
References: <1421691358-14661-1-git-send-email-tony@atomide.com>
Message-ID: <1421691358-14661-3-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have pcf857x at least several boards. Let's enable it
as a loadable module.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index d6f84f2..3ac8269 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -205,6 +205,7 @@ CONFIG_SPI_TI_QSPI=m
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_DEBUG_GPIO=y
 CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_PCF857X=m
 CONFIG_GPIO_TWL4030=y
 CONFIG_W1=m
 CONFIG_HDQ_MASTER_OMAP=m
-- 
2.1.4
