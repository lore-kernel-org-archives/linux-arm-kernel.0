From: wanlong.gao@gmail.com (Wanlong Gao)
Date: Sun, 24 Jul 2011 11:24:32 +0800
Subject: [PATCH] ARM:mach-dove:remove the dup include serial_8250.h
Message-ID: <1311477872-4329-1-git-send-email-wanlong.gao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wanlong Gao <gaowanlong@cn.fujitsu.com>

linux/serial_8250.h has been included for twice.

Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
---
 arch/arm/mach-dove/common.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index 5ed51b8..b6c3d6b 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -17,7 +17,6 @@
 #include <linux/clk.h>
 #include <linux/mbus.h>
 #include <linux/ata_platform.h>
-#include <linux/serial_8250.h>
 #include <linux/gpio.h>
 #include <asm/page.h>
 #include <asm/setup.h>
-- 
1.7.4.1
