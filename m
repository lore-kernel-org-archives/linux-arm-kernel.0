From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 2 May 2012 19:31:21 +0800
Subject: [PATCH 2/3] ARM: imx6q: switch to use pinctrl subsystem
In-Reply-To: <1335958282-3068-1-git-send-email-b29396@freescale.com>
References: <1335958282-3068-1-git-send-email-b29396@freescale.com>
Message-ID: <1335958282-3068-2-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 arch/arm/mach-imx/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 7561eca..e0fc67c 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -842,6 +842,8 @@ config SOC_IMX6Q
 	select HAVE_IMX_MMDC
 	select HAVE_IMX_SRC
 	select HAVE_SMP
+	select PINCTRL
+	select PINCTRL_IMX6Q
 	select USE_OF
 
 	help
-- 
1.7.0.4
