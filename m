From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 4 Oct 2011 21:26:53 +0100
Subject: [PATCH] picoxcell: add a definition of VMALLOC_END
In-Reply-To: <1317759855-21281-1-git-send-email-jamie@jamieiles.com>
References: <1317759855-21281-1-git-send-email-jamie@jamieiles.com>
Message-ID: <20111004202653.GA12252@gallagher>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 04, 2011 at 09:24:15PM +0100, Jamie Iles wrote:
> Nicolas Pitre's vmalloc cleanup series didn't get merged in this cycle
> so picoxcell is missing a VMALLOC_END definition.
> 
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>

Oops.  Wrong patch, should have been this one.

8<----

From: Jamie Iles <jamie@jamieiles.com>
Subject: [PATCH] picoxcell: add a definition of VMALLOC_END

Nicolas Pitre's vmalloc cleanup series didn't get merged in this cycle
so picoxcell is missing a VMALLOC_END definition.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mach-picoxcell/include/mach/vmalloc.h |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-picoxcell/include/mach/vmalloc.h

diff --git a/arch/arm/mach-picoxcell/include/mach/vmalloc.h b/arch/arm/mach-picoxcell/include/mach/vmalloc.h
new file mode 100644
index 0000000..0216cc4
--- /dev/null
+++ b/arch/arm/mach-picoxcell/include/mach/vmalloc.h
@@ -0,0 +1,14 @@
+/*
+ * Copyright (c) 2011 Picochip Ltd., Jamie Iles
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
