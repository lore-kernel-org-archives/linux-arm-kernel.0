From: richard.zhao@linaro.org (Richard Zhao)
Date: Fri, 30 Dec 2011 10:56:09 +0800
Subject: [PATCH V6 7/7] arm/imx6q: select ARCH_HAS_CPUFREQ
In-Reply-To: <1325213769-11752-1-git-send-email-richard.zhao@linaro.org>
References: <1325213769-11752-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1325213769-11752-8-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/mach-imx/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index c44aa97..39cf00a 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -595,6 +595,7 @@ comment "i.MX6 family:"
 
 config SOC_IMX6Q
 	bool "i.MX6 Quad support"
+	select ARCH_HAS_CPUFREQ
 	select ARM_GIC
 	select CACHE_L2X0
 	select CPU_V7
-- 
1.7.5.4
