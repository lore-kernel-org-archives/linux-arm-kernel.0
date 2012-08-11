From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 11 Aug 2012 02:39:46 +0000
Subject: [PATCH 2/3] ARM: Kirkwood: ts219: fix Makefile.boot after dts was
 split in two
In-Reply-To: <cover.1344651264.git.jason@lakedaemon.net>
References: <cover.1344651264.git.jason@lakedaemon.net>
Message-ID: <4b59ab4618c9b9c055831f6b96636741bda5d42f.1344651264.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 arch/arm/mach-kirkwood/Makefile.boot |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-kirkwood/Makefile.boot b/arch/arm/mach-kirkwood/Makefile.boot
index 2a576ab..2ad83e2 100644
--- a/arch/arm/mach-kirkwood/Makefile.boot
+++ b/arch/arm/mach-kirkwood/Makefile.boot
@@ -7,7 +7,7 @@ dtb-$(CONFIG_MACH_DLINK_KIRKWOOD_DT) += kirkwood-dns320.dtb
 dtb-$(CONFIG_MACH_DLINK_KIRKWOOD_DT) += kirkwood-dns325.dtb
 dtb-$(CONFIG_MACH_ICONNECT_DT) += kirkwood-iconnect.dtb
 dtb-$(CONFIG_MACH_IB62X0_DT) += kirkwood-ib62x0.dtb
-dtb-$(CONFIG_MACH_TS219_DT)	+= kirkwood-qnap-ts219.dtb
+dtb-$(CONFIG_MACH_TS219_DT)	+= kirkwood-ts219-6281.dtb kirkwood-ts219-6282.dtb
 dtb-$(CONFIG_MACH_GOFLEXNET_DT) += kirkwood-goflexnet.dtb
 dbt-$(CONFIG_MACH_LSXL_DT) += kirkwood-lschlv2.dtb
 dbt-$(CONFIG_MACH_LSXL_DT) += kirkwood-lsxhl.dtb
-- 
1.7.8.6
