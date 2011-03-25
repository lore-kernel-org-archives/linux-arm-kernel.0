From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Fri, 25 Mar 2011 09:29:01 -0600
Subject: [PATCH 8/8] ux500: Kconfig for snowball board
In-Reply-To: <1301066941-15877-1-git-send-email-mathieu.poirier@linaro.org>
References: <1301066941-15877-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1301066941-15877-9-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu J. Poirier <mathieu.poirier@linaro.org>

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 arch/arm/mach-ux500/Kconfig |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 7f8620f..ba5c270 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -26,6 +26,12 @@ config MACH_U8500
 	help
 	  Include support for the mop500 development platform.
 
+config MACH_U8500_SNOWBALL
+	bool "U8500 Snowball platform"
+	depends on UX500_SOC_DB8500
+	help
+	  Include support for the snowball development platform.
+
 config MACH_U5500
 	bool "U5500 Development platform"
 	depends on UX500_SOC_DB5500
-- 
1.7.1
