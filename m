From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 28 Jun 2013 19:29:30 +0900
Subject: [PATCH 00/06] ARM: shmobile: Remove unused auxdata tables
Message-ID: <20130628102930.31451.85334.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: Remove unused auxdata tables

[PATCH 01/06] ARM: shmobile: Remove unused EMEV2 auxdata table
[PATCH 02/06] ARM: shmobile: Remove unused r8a7740 auxdata table
[PATCH 03/06] ARM: shmobile: Remove unused r8a7778 auxdata table
[PATCH 04/06] ARM: shmobile: Remove unused r8a7779 auxdata table
[PATCH 05/06] ARM: shmobile: Remove unused sh7372 auxdata table
[PATCH 06/06] ARM: shmobile: Remove unused sh73a0 auxdata table

Rework the mach-shmobile code to pass NULL to of_platform_populate()
instead of empty lists. This cleans up the code and reduces the
number of lines. The recently added SoCs r8a7790 and r8a73a4 are
already following this style, so no need to touch them.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git renesas-next-20130628

 arch/arm/mach-shmobile/setup-emev2.c   |    6 +-----
 arch/arm/mach-shmobile/setup-r8a7740.c |    7 +------
 arch/arm/mach-shmobile/setup-r8a7778.c |    7 +------
 arch/arm/mach-shmobile/setup-r8a7779.c |    7 +------
 arch/arm/mach-shmobile/setup-sh7372.c  |    7 +------
 arch/arm/mach-shmobile/setup-sh73a0.c  |    7 +------
 6 files changed, 6 insertions(+), 35 deletions(-)
