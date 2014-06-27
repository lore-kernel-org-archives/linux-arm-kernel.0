From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 27 Jun 2014 11:49:27 +0800
Subject: [PATCH v4 04/13] ARM64 : Add dummy asm/cpu.h
In-Reply-To: <1403840976-7456-1-git-send-email-hanjun.guo@linaro.org>
References: <1403840976-7456-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1403840976-7456-5-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Graeme Gregory <graeme.gregory@linaro.org>

ACPI core requires a cpu.h, add a dummy one here temporarily.
This file will be updated in the future to add definitions for
arch_(un)register_cpu which are required for ACPI based physical
CPU hotplug when these standards have be ratified by the ASWG.

Reviewed-by: Grant Likely <grant.likely@linaro.org>
Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/include/asm/cpu.h |   11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 arch/arm64/include/asm/cpu.h

diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
new file mode 100644
index 0000000..cee7d3f
--- /dev/null
+++ b/arch/arm64/include/asm/cpu.h
@@ -0,0 +1,11 @@
+/*
+ *  Copyright (C) 2013-2014 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __ASM_CPU_H
+#define __ASM_CPU_H
+
+#endif
-- 
1.7.9.5
