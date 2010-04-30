From: tony@atomide.com (Tony Lindgren)
Date: Fri, 30 Apr 2010 13:34:09 -0700
Subject: [PATCH 10/11] omap2/3/4: Dissable CONFIG_PM_VERBOSE in omap3_defconfig
In-Reply-To: <20100430202603.25812.41834.stgit@baageli.muru.com>
References: <20100430202603.25812.41834.stgit@baageli.muru.com>
Message-ID: <20100430203409.25812.56272.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's too noisy.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap3_defconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/omap3_defconfig b/arch/arm/configs/omap3_defconfig
index a846836..7855edb 100644
--- a/arch/arm/configs/omap3_defconfig
+++ b/arch/arm/configs/omap3_defconfig
@@ -444,7 +444,7 @@ CONFIG_BINFMT_MISC=y
 #
 CONFIG_PM=y
 CONFIG_PM_DEBUG=y
-CONFIG_PM_VERBOSE=y
+# CONFIG_PM_VERBOSE is not set
 CONFIG_CAN_PM_TRACE=y
 CONFIG_PM_SLEEP=y
 CONFIG_SUSPEND=y
