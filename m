From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 24 Aug 2012 11:09:17 +0200
Subject: [PATCH 2/6] arm: cache-l2x0: add an optional register to save/restore
In-Reply-To: <1345799361-23735-1-git-send-email-gregory.clement@free-electrons.com>
References: <1345799361-23735-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1345799361-23735-3-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Barry Song <21cnbao@gmail.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
---
 arch/arm/include/asm/hardware/cache-l2x0.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index c4c87bc..5f2c7b4 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -126,6 +126,7 @@ struct l2x0_regs {
 	unsigned long filter_end;
 	unsigned long prefetch_ctrl;
 	unsigned long pwr_ctrl;
+	unsigned long ctrl;
 };
 
 extern struct l2x0_regs l2x0_saved_regs;
-- 
1.7.9.5
