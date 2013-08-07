From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 08 Aug 2013 07:55:31 +0900
Subject: [PATCH 00/02] ARM: shmobile: Initial r8a73a4 APMU SMP code
Message-ID: <20130807225531.9856.18974.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: Initial r8a73a4 APMU SMP code

[PATCH 01/02] ARM: shmobile: Add r8a73a4 SMP support using APMU code
[PATCH 02/02] ARM: shmobile: Add r8a73a4 CA15 CPU cores and APMU as DTS

This series adds SMP support to r8a73a4 using the APMU code. With these
patches applied r8a73a4 CA15 support for SMP boot and CPU Hotplug is
known to be working.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git renesas-devel-20130806v4 and
 [PATCH 00/05] ARM: shmobile: Yet another SMP series
 [PATCH 00/02] ARM: shmobile: Rename to r8a73a4/r8a7790_init_early()
 [PATCH] ARM: shmobile: Shared APMU SMP support code

 arch/arm/boot/dts/r8a73a4.dtsi                |   27 +++++++++
 arch/arm/mach-shmobile/Makefile               |    1 
 arch/arm/mach-shmobile/include/mach/r8a73a4.h |    1 
 arch/arm/mach-shmobile/setup-r8a73a4.c        |    3 +
 arch/arm/mach-shmobile/smp-r8a73a4.c          |   75 +++++++++++++++++++++++++
 5 files changed, 107 insertions(+)
