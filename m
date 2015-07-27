From: haibo.chen@freescale.com (Haibo Chen)
Date: Mon, 27 Jul 2015 19:26:45 +0800
Subject: [PATCH 3/5] ARM: imx_v6_v7_defconfig: enable imx6ul_tsc
In-Reply-To: <1437996407-27266-1-git-send-email-haibo.chen@freescale.com>
References: <1437996407-27266-1-git-send-email-haibo.chen@freescale.com>
Message-ID: <1437996407-27266-4-git-send-email-haibo.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable imx6ul touchscreen controller

Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index e1ba3e2..9823ddc 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -157,6 +157,7 @@ CONFIG_MOUSE_PS2=m
 CONFIG_MOUSE_PS2_ELANTECH=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_EGALAX=y
+CONFIG_TOUCHSCREEN_IMX6UL_TSC=y
 CONFIG_TOUCHSCREEN_MC13783=y
 CONFIG_TOUCHSCREEN_TSC2007=y
 CONFIG_TOUCHSCREEN_STMPE=y
-- 
1.9.1
