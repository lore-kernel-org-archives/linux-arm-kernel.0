From: bryan.wu@canonical.com (Bryan Wu)
Date: Fri,  6 May 2011 16:27:05 +0800
Subject: [PATCH 2/2] arm: localtimer: fix typo in help message
In-Reply-To: <1304670425-26672-1-git-send-email-bryan.wu@canonical.com>
References: <1304670425-26672-1-git-send-email-bryan.wu@canonical.com>
Message-ID: <1304670425-26672-2-git-send-email-bryan.wu@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
---
 arch/arm/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 377a7a5..491eb50 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1414,7 +1414,7 @@ config LOCAL_TIMERS
 	default y
 	select HAVE_ARM_TWD if (!ARCH_MSM_SCORPIONMP && !EXYNOS4_MCT)
 	help
-	  Enable support for local timers on SMP platforms, rather then the
+	  Enable support for local timers on SMP platforms, rather than the
 	  legacy IPI broadcast method.  Local timers allows the system
 	  accounting to be spread across the timer interval, preventing a
 	  "thundering herd" at every timer tick.
-- 
1.7.5
