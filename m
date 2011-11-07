From: richard.zhao@linaro.org (Richard Zhao)
Date: Mon, 7 Nov 2011 11:02:16 +0800
Subject: [PATCH 2/2] ARM: mxc: fix tzic build error
In-Reply-To: <1320634936-7898-1-git-send-email-richard.zhao@linaro.org>
References: <1320634936-7898-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1320634936-7898-2-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/plat-mxc/tzic.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/tzic.c b/arch/arm/plat-mxc/tzic.c
index e993a18..a3c164c 100644
--- a/arch/arm/plat-mxc/tzic.c
+++ b/arch/arm/plat-mxc/tzic.c
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 
 #include <asm/mach/irq.h>
+#include <asm/exception.h>
 
 #include <mach/hardware.h>
 #include <mach/common.h>
-- 
1.7.5.4
