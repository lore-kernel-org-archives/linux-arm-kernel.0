From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 07 Nov 2013 08:30:32 +0900
Subject: [PATCH 00/03] ARM: shmobile: r7s72100 Genmai DT reference and
 multiplatform
Message-ID: <20131106233032.8117.71968.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: r7s72100 Genmai DT reference and multiplatform

[PATCH 01/03] ARM: shmobile: r7s72100 Genmai DT reference DTS bits
[PATCH 02/03] ARM: shmobile: r7s72100 Genmai DT reference C bits
[PATCH 03/03] ARM: shmobile: r7s72100 Genmai Multiplatform

Add r7s72100 Genmai DT reference support and add it to SHMOBILE_MULTI. To
use multiplatform support CCF is also needed, so at this point Genmai
multiplatform is build-only until CCF makes it possible to boot the board.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git tag renesas-devel-v3.12-rc7-20131101 and
 [PATCH] ARM: shmobile: Initial r8a7791 and Koelsch multiplatform support 

 arch/arm/boot/dts/Makefile                      |    2 
 arch/arm/boot/dts/r7s72100-genmai-reference.dts |   31 ++++++++++++++
 arch/arm/mach-shmobile/Kconfig                  |   18 ++++++++
 arch/arm/mach-shmobile/Makefile                 |    2 
 arch/arm/mach-shmobile/Makefile.boot            |    3 -
 arch/arm/mach-shmobile/board-genmai-reference.c |   49 +++++++++++++++++++++++
 6 files changed, 104 insertions(+), 1 deletion(-)
