From: pebolle@tiscali.nl (Paul Bolle)
Date: Sun, 06 Apr 2014 11:57:05 +0200
Subject: [PATCH] ARM: msm: Remove MSM_SCM
Message-ID: <1396778225.30640.12.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 8fc1b0f87d9f ("ARM: qcom: Split Qualcomm support into legacy and
multiplatform") removed all users of Kconfig symbol MSM_SCM. Remove that
symbol too.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Tested only by grepping the tree.

 arch/arm/mach-msm/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
index a7f959e58c3d..be8413abfa4f 100644
--- a/arch/arm/mach-msm/Kconfig
+++ b/arch/arm/mach-msm/Kconfig
@@ -109,7 +109,4 @@ config MSM_GPIOMUX
 	help
 	  Support for MSM V1 TLMM GPIOMUX architecture.
 
-config MSM_SCM
-	bool
-
 endif
-- 
1.9.0
