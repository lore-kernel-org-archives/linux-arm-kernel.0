From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 01 May 2015 12:06:31 -0400
Subject: [PATCH 4/5] ARM: MCPM: add references to the available documentation
 in the code
In-Reply-To: <1430496392-15956-1-git-send-email-nicolas.pitre@linaro.org>
References: <1430496392-15956-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1430496392-15956-5-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/common/mcpm_entry.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/common/mcpm_entry.c b/arch/arm/common/mcpm_entry.c
index c5fe2e33e6..492467587c 100644
--- a/arch/arm/common/mcpm_entry.c
+++ b/arch/arm/common/mcpm_entry.c
@@ -20,6 +20,11 @@
 #include <asm/cputype.h>
 #include <asm/suspend.h>
 
+/*
+ * The public API for this code is documented in arch/arm/include/asm/mcpm.h.
+ * For a comprehensive description of the main algorithm used here, please
+ * see Documentation/arm/cluster-pm-race-avoidance.txt.
+ */
 
 struct sync_struct mcpm_sync;
 
-- 
2.1.0
