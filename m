From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun,  5 Aug 2012 16:45:32 +0200
Subject: [PATCH 1/1] ARM: kirkwood: fix typo in Makefile.boot
Message-ID: <1344177932-6466-1-git-send-email-sebastian.hesselbarth@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just a small typo fix to make lsxl dtbs compile

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/mach-kirkwood/Makefile.boot |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-kirkwood/Makefile.boot b/arch/arm/mach-kirkwood/Makefile.boot
index 2a576ab..a571755 100644
--- a/arch/arm/mach-kirkwood/Makefile.boot
+++ b/arch/arm/mach-kirkwood/Makefile.boot
@@ -9,5 +9,5 @@ dtb-$(CONFIG_MACH_ICONNECT_DT) += kirkwood-iconnect.dtb
 dtb-$(CONFIG_MACH_IB62X0_DT) += kirkwood-ib62x0.dtb
 dtb-$(CONFIG_MACH_TS219_DT)	+= kirkwood-qnap-ts219.dtb
 dtb-$(CONFIG_MACH_GOFLEXNET_DT) += kirkwood-goflexnet.dtb
-dbt-$(CONFIG_MACH_LSXL_DT) += kirkwood-lschlv2.dtb
-dbt-$(CONFIG_MACH_LSXL_DT) += kirkwood-lsxhl.dtb
+dtb-$(CONFIG_MACH_LSXL_DT) += kirkwood-lschlv2.dtb
+dtb-$(CONFIG_MACH_LSXL_DT) += kirkwood-lsxhl.dtb
-- 
1.7.10.4
