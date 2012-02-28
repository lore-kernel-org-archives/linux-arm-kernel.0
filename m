From: javier.martin@vista-silicon.com (Javier Martin)
Date: Tue, 28 Feb 2012 17:31:48 +0100
Subject: [PATCH v2 1/4] i.MX27: visstrim_m10: Sort IMX_HAVE_PLATFORM_MXC_MMC
 properly.
In-Reply-To: <1330446711-6970-1-git-send-email-javier.martin@vista-silicon.com>
References: <1330446711-6970-1-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <1330446711-6970-2-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 arch/arm/mach-imx/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 4defb97..3d82133 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -320,8 +320,8 @@ config MACH_IMX27_VISSTRIM_M10
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_SSI
 	select IMX_HAVE_PLATFORM_IMX_UART
-	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_MXC_EHCI
+	select IMX_HAVE_PLATFORM_MXC_MMC
 	help
 	  Include support for Visstrim_m10 platform and its different variants.
 	  This includes specific configurations for the board and its
-- 
1.7.0.4
