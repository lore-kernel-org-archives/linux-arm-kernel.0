From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 20 May 2011 17:57:26 +0800
Subject: [PATCH 3/3] ARM: mxs: select GPIO_MXS for i.MX23 and i.MX28
In-Reply-To: <1305885446-27404-1-git-send-email-shawn.guo@linaro.org>
References: <1305885446-27404-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1305885446-27404-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index 21de5d5..afb1b44 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -8,11 +8,13 @@ config MXS_OCOTP
 config SOC_IMX23
 	bool
 	select CPU_ARM926T
+	select GPIO_MXS
 	select HAVE_PWM
 
 config SOC_IMX28
 	bool
 	select CPU_ARM926T
+	select GPIO_MXS
 	select HAVE_PWM
 
 comment "MXS platforms:"
-- 
1.7.4.1
