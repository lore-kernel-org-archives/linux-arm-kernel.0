From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Wed, 22 Apr 2015 05:43:27 +0800
Subject: [PATCH v6 08/11] ARM: imx: add gpt system timer support for imx7d
In-Reply-To: <1429652610-25265-1-git-send-email-Frank.Li@freescale.com>
References: <1429652610-25265-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <1429652610-25265-9-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

Add GPT system timer support for i.MX7D, it has same hardware
as i.MX6DL.

Signed-off-by: Frank Li <Frank.Li@freescale.com>
Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/mach-imx/time.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index 15d18e1..5833ac4 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -383,3 +383,4 @@ CLOCKSOURCE_OF_DECLARE(mx53_timer, "fsl,imx53-gpt", mxc_timer_init_dt);
 CLOCKSOURCE_OF_DECLARE(mx6q_timer, "fsl,imx6q-gpt", mxc_timer_init_dt);
 CLOCKSOURCE_OF_DECLARE(mx6sl_timer, "fsl,imx6sl-gpt", mxc_timer_init_dt);
 CLOCKSOURCE_OF_DECLARE(mx6sx_timer, "fsl,imx6sx-gpt", mxc_timer_init_dt);
+CLOCKSOURCE_OF_DECLARE(mx7d_timer, "fsl,imx7d-gpt", mxc_timer_init_dt);
-- 
1.9.1
