From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 23 Feb 2016 14:34:28 +0000
Subject: [PATCH v4 10/10] MAINTAINERS: Update ARM Versatile Express platform
 entry
In-Reply-To: <1456238068-25079-1-git-send-email-vladimir.murzin@arm.com>
References: <1456238068-25079-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1456238068-25079-11-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch update ARM Versatile Express entry to cover bits needed for
Cortex-M Prototyping System (MPS2 platform). So patches for the latter
are collected by existing Vexpress and Juno maintainers (Liviu, Sudeep,
Lorenzo) and find their way upstream via Vexpess and/or Juno trees.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 MAINTAINERS |    1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4978dc1..e827e3b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1726,6 +1726,7 @@ F:	*/*/vexpress*
 F:	*/*/*/vexpress*
 F:	drivers/clk/versatile/clk-vexpress-osc.c
 F:	drivers/clocksource/versatile.c
+N:	mps2
 
 ARM/VFP SUPPORT
 M:	Russell King <linux@arm.linux.org.uk>
-- 
1.7.9.5
