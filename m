From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 05 Jun 2013 16:07:37 +0900
Subject: [PATCH 10/15] ARM: shmobile: Kota2 uImage rework
In-Reply-To: <20130605070616.13311.69049.sendpatchset@w520>
References: <20130605070616.13311.69049.sendpatchset@w520>
Message-ID: <20130605070737.13311.86194.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add Kota2 specific load address to Makefile.boot

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Makefile.boot |    1 +
 1 file changed, 1 insertion(+)

--- 0017/arch/arm/mach-shmobile/Makefile.boot
+++ work/arch/arm/mach-shmobile/Makefile.boot	2013-06-04 16:41:09.000000000 +0900
@@ -7,6 +7,7 @@ loadaddr-$(CONFIG_MACH_APE6EVM) += 0x400
 loadaddr-$(CONFIG_MACH_ARMADILLO800EVA) += 0x40008000
 loadaddr-$(CONFIG_MACH_BOCKW) += 0x60008000
 loadaddr-$(CONFIG_MACH_BONITO) += 0x40008000
+loadaddr-$(CONFIG_MACH_KOTA2) += 0x41008000
 loadaddr-$(CONFIG_MACH_KZM9D) += 0x40008000
 loadaddr-$(CONFIG_MACH_KZM9G) += 0x41008000
 loadaddr-$(CONFIG_MACH_KZM9G_REFERENCE) += 0x41008000
