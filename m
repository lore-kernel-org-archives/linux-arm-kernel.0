From: siccegge@cs.fau.de (Christoph Egger)
Date: Wed, 30 Jun 2010 18:05:38 +0200
Subject: [PATCH 02/33] Removing dead ARCH_DAVINCI_TNETV107X
In-Reply-To: <cover.1277911345.git.siccegge@cs.fau.de>
References: <cover.1277911345.git.siccegge@cs.fau.de>
Message-ID: <88ee583babc6f0aecb2238a57644f64159d5c395.1277911346.git.siccegge@cs.fau.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARCH_DAVINCI_TNETV107X doesn't exist in Kconfig, therefore removing
all references for it from the source code.

Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
---
 arch/arm/mach-davinci/include/mach/cputype.h |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/cputype.h b/arch/arm/mach-davinci/include/mach/cputype.h
index cea6b89..6143022 100644
--- a/arch/arm/mach-davinci/include/mach/cputype.h
+++ b/arch/arm/mach-davinci/include/mach/cputype.h
@@ -85,10 +85,4 @@ IS_DAVINCI_CPU(tnetv107x, DAVINCI_CPU_ID_TNETV107X)
 #define cpu_is_davinci_da850() 0
 #endif
 
-#ifdef CONFIG_ARCH_DAVINCI_TNETV107X
-#define cpu_is_davinci_tnetv107x() is_davinci_tnetv107x()
-#else
-#define cpu_is_davinci_tnetv107x() 0
-#endif
-
 #endif
-- 
1.7.0.4
