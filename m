From: jamie@jamieiles.com (Jamie Iles)
Date: Tue,  4 Oct 2011 21:24:15 +0100
Subject: [PATCH] picoxcell: add a definition of VMALLOC_END
Message-ID: <1317759855-21281-1-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Pitre's vmalloc cleanup series didn't get merged in this cycle
so picoxcell is missing a VMALLOC_END definition.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mach-picoxcell/include/mach/vmalloc.h |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-picoxcell/include/mach/vmalloc.h

diff --git a/arch/arm/mach-picoxcell/include/mach/vmalloc.h b/arch/arm/mach-picoxcell/include/mach/vmalloc.h
new file mode 100644
index 0000000..0a4bb0e
--- /dev/null
+++ b/arch/arm/mach-picoxcell/include/mach/vmalloc.h
@@ -0,0 +1,16 @@
+/*
+ * Copyright (c) 2011 Picochip Ltd., Jamie Iles
+ *
+ * This file contains the hardware definitions of the picoXcell SoC devices.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#define VMALLOC_END	0xfe000000UL
-- 
1.7.4.1
