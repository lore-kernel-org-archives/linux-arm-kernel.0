From: peter.chen@nxp.com (Peter Chen)
Date: Mon, 14 Nov 2016 15:04:21 +0800
Subject: [PATCH v3 2/3] ARM: imx: mach-imx6ul: add imx6ull support
In-Reply-To: <1479107062-15365-1-git-send-email-peter.chen@nxp.com>
References: <1479107062-15365-1-git-send-email-peter.chen@nxp.com>
Message-ID: <1479107062-15365-3-git-send-email-peter.chen@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imx6ull is derived SoC from imx6ul.

Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 arch/arm/mach-imx/mach-imx6ul.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/mach-imx6ul.c b/arch/arm/mach-imx/mach-imx6ul.c
index 58a2b88..6cb8a22 100644
--- a/arch/arm/mach-imx/mach-imx6ul.c
+++ b/arch/arm/mach-imx/mach-imx6ul.c
@@ -89,6 +89,7 @@ static void __init imx6ul_init_late(void)
 
 static const char * const imx6ul_dt_compat[] __initconst = {
 	"fsl,imx6ul",
+	"fsl,imx6ull",
 	NULL,
 };
 
-- 
2.7.4
