From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 25 Apr 2016 09:49:17 +0100
Subject: [PATCH 5/5] MAINTAINERS: Update ARM Versatile Express platform entry
In-Reply-To: <1461574157-23580-1-git-send-email-vladimir.murzin@arm.com>
References: <1461574157-23580-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1461574157-23580-6-git-send-email-vladimir.murzin@arm.com>
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
index 03e00c7..9f07e7c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1771,6 +1771,7 @@ F:	*/*/vexpress*
 F:	*/*/*/vexpress*
 F:	drivers/clk/versatile/clk-vexpress-osc.c
 F:	drivers/clocksource/versatile.c
+N:	mps2
 
 ARM/VFP SUPPORT
 M:	Russell King <linux@arm.linux.org.uk>
-- 
1.7.9.5
