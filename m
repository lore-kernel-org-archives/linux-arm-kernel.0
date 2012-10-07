From: linux@prisktech.co.nz (Tony Prisk)
Date: Sun,  7 Oct 2012 14:02:13 +1300
Subject: [PATCH 3/4] vt8500: Fix header in mach-vt8500/timer.c
In-Reply-To: <1349571734-26233-1-git-send-email-linux@prisktech.co.nz>
References: <1349571734-26233-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1349571734-26233-4-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Correct filename reference in file header.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 arch/arm/mach-vt8500/timer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-vt8500/timer.c b/arch/arm/mach-vt8500/timer.c
index 050e183..3dd21a4 100644
--- a/arch/arm/mach-vt8500/timer.c
+++ b/arch/arm/mach-vt8500/timer.c
@@ -1,5 +1,5 @@
 /*
- *  arch/arm/mach-vt8500/timer_dt.c
+ *  arch/arm/mach-vt8500/timer.c
  *
  *  Copyright (C) 2012 Tony Prisk <linux@prisktech.co.nz>
  *  Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
-- 
1.7.9.5
