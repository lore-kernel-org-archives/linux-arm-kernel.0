From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu,  6 May 2010 16:24:12 -0700
Subject: [PATCH 21/34] davinci: mach/common.h: add missing includes
In-Reply-To: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
References: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1273188265-12782-22-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Koeller <thomas.koeller@baslerweb.com>

linux/compiler.h is required for __iomem
linux/types.h is required u32

Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/include/mach/common.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 50a955f..d88104e 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -12,6 +12,9 @@
 #ifndef __ARCH_ARM_MACH_DAVINCI_COMMON_H
 #define __ARCH_ARM_MACH_DAVINCI_COMMON_H
 
+#include <linux/compiler.h>
+#include <linux/types.h>
+
 struct sys_timer;
 
 extern struct sys_timer davinci_timer;
-- 
1.7.0.2
