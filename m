From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 01 Oct 2013 17:11:43 +0900
Subject: [PATCH 00/10] ARM: shmobile: r8a7791 SoC and Koelsch update V2
Message-ID: <20131001081143.4136.46925.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: r8a7791 SoC and Koelsch update V2

[PATCH 01/10] ARM: shmobile: Introduce r8a7791_add_standard_devices()
[PATCH 02/10] ARM: shmobile: Use r8a7791_add_standard_devices() on Koelsch
[PATCH 03/10] ARM: shmobile: r8a7791 IRQC platform device support
[PATCH 04/10] ARM: shmobile: r8a7791 IRQC device tree node
[PATCH 05/10] ARM: shmobile: r8a7791 Arch timer device tree node
[PATCH 06/10] ARM: shmobile: r8a7791 Arch timer workaround
[PATCH 07/10] ARM: shmobile: Use arch timer on Koelsch
[PATCH 08/10] ARM: shmobile: r8a7791 SMP device tree node
[PATCH 09/10] ARM: shmobile: r8a7791 SMP support
[PATCH 10/10] ARM: shmobile: Use SMP on Koelsch

This series includes updated and more broken out versions of patches
implementing r8a7791 and Koelsch support for IRQC, Arch timer and SMP.

Koelsch DT reference support needs to be rebuilt on top of this
in the near future. After that will PFC and GPIO be layered on top.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git tag renesas-devel-20131001

 arch/arm/boot/dts/r8a7791.dtsi                |   33 +++++++++++++
 arch/arm/mach-shmobile/Makefile               |    3 -
 arch/arm/mach-shmobile/board-koelsch.c        |    5 +-
 arch/arm/mach-shmobile/include/mach/r8a7791.h |    2 
 arch/arm/mach-shmobile/setup-r8a7791.c        |   35 ++++++++++++++
 arch/arm/mach-shmobile/smp-r8a7791.c          |   62 +++++++++++++++++++++++++
 6 files changed, 138 insertions(+), 2 deletions(-)
