From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 28 Sep 2011 17:16:04 +0800
Subject: [PATCH 2/6] arm/imx: rename mm-imx31.c to mm-imx3.c
In-Reply-To: <1317201368-6403-1-git-send-email-shawn.guo@linaro.org>
References: <1317201368-6403-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1317201368-6403-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since mm-imx31.c now is shared between imx31 and imx35, the patch
renames mm-imx31.c to mm-imx3.c.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/Makefile                  |    4 ++--
 arch/arm/mach-imx/{mm-imx31.c => mm-imx3.c} |    0
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/arm/mach-imx/{mm-imx31.c => mm-imx3.c} (100%)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 940f130..fb5dfd5 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -8,8 +8,8 @@ obj-$(CONFIG_SOC_IMX25) += clock-imx25.o mm-imx25.o ehci-imx25.o cpu-imx25.o
 obj-$(CONFIG_SOC_IMX27) += cpu-imx27.o pm-imx27.o
 obj-$(CONFIG_SOC_IMX27) += clock-imx27.o mm-imx27.o ehci-imx27.o
 
-obj-$(CONFIG_SOC_IMX31) += mm-imx31.o cpu-imx31.o clock-imx31.o iomux-imx31.o ehci-imx31.o
-obj-$(CONFIG_SOC_IMX35) += mm-imx31.o cpu-imx35.o clock-imx35.o ehci-imx35.o
+obj-$(CONFIG_SOC_IMX31) += mm-imx3.o cpu-imx31.o clock-imx31.o iomux-imx31.o ehci-imx31.o
+obj-$(CONFIG_SOC_IMX35) += mm-imx3.o cpu-imx35.o clock-imx35.o ehci-imx35.o
 obj-$(CONFIG_CACHE_L2X0) += cache-l2x0.o
 
 # Support for CMOS sensor interface
diff --git a/arch/arm/mach-imx/mm-imx31.c b/arch/arm/mach-imx/mm-imx3.c
similarity index 100%
rename from arch/arm/mach-imx/mm-imx31.c
rename to arch/arm/mach-imx/mm-imx3.c
-- 
1.7.4.1
