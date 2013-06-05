From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 05 Jun 2013 16:08:12 +0900
Subject: [PATCH 14/15] ARM: shmobile: Armadillo800EVA reference uImage rework
In-Reply-To: <20130605070616.13311.69049.sendpatchset@w520>
References: <20130605070616.13311.69049.sendpatchset@w520>
Message-ID: <20130605070812.13311.58716.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add uImage load address to Makefile.boot for the recently
added Armadillo800EVA DT Reference code

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Makefile.boot |    1 +
 1 file changed, 1 insertion(+)

--- 0015/arch/arm/mach-shmobile/Makefile.boot
+++ work/arch/arm/mach-shmobile/Makefile.boot	2013-06-05 15:59:33.000000000 +0900
@@ -4,6 +4,7 @@ loadaddr-$(CONFIG_MACH_AG5EVM) += 0x4000
 loadaddr-$(CONFIG_MACH_AP4EVB) += 0x40008000
 loadaddr-$(CONFIG_MACH_APE6EVM) += 0x40008000
 loadaddr-$(CONFIG_MACH_ARMADILLO800EVA) += 0x40008000
+loadaddr-$(CONFIG_MACH_ARMADILLO800EVA_REFERENCE) += 0x40008000
 loadaddr-$(CONFIG_MACH_BOCKW) += 0x60008000
 loadaddr-$(CONFIG_MACH_BONITO) += 0x40008000
 loadaddr-$(CONFIG_MACH_KOTA2) += 0x41008000
