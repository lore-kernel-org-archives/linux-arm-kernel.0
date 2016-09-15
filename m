From: netz.kernel@gmail.com (Marty Plummer)
Date: Thu, 15 Sep 2016 16:05:02 -0500
Subject: [RFC PATCH v2 2/5] clk: hi3620: Make 3620 explicit, remove wildcard
In-Reply-To: <20160915210505.21878-1-netz.kernel@gmail.com>
References: <20160915210505.21878-1-netz.kernel@gmail.com>
Message-ID: <20160915210505.21878-3-netz.kernel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marty Plummer <netz.kernel@gmail.com>
---
 drivers/clk/hisilicon/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/hisilicon/Makefile b/drivers/clk/hisilicon/Makefile
index e169ec7..2edf3b5 100644
--- a/drivers/clk/hisilicon/Makefile
+++ b/drivers/clk/hisilicon/Makefile
@@ -4,7 +4,7 @@
 
 obj-y	+= clk.o clkgate-separated.o clkdivider-hi6220.o
 
-obj-$(CONFIG_ARCH_HI3xxx)	+= clk-hi3620.o
+obj-$(CONFIG_ARCH_HI3620)	+= clk-hi3620.o
 obj-$(CONFIG_ARCH_HIP04)	+= clk-hip04.o
 obj-$(CONFIG_ARCH_HIX5HD2)	+= clk-hix5hd2.o
 obj-$(CONFIG_COMMON_CLK_HI3519)	+= clk-hi3519.o
-- 
2.9.3
