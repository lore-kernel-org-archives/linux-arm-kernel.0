From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 08 Aug 2013 07:26:38 +0900
Subject: [PATCH 00/02] ARM: shmobile: Rename to r8a73a4/r8a7790_init_early()
Message-ID: <20130807222638.22283.78607.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: Rename to r8a73a4/r8a7790_init_early()

[PATCH 01/02] ARM: shmobile: Rename to r8a73a4_init_early()
[PATCH 02/02] ARM: shmobile: Rename to r8a7790_init_early()

This series renames r8a73a4/r8a7790_init_delay() to 
r8a73a4/r8a7790_init_early(). The reason for this is
that future SMP code will hook into these functions
which will make them handle more than just delay setup.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git renesas-devel-20130806v4 and
 [PATCH 00/05] ARM: shmobile: Yet another SMP series

 arch/arm/mach-shmobile/board-ape6evm-reference.c |    2 +-
 arch/arm/mach-shmobile/board-ape6evm.c           |    2 +-
 arch/arm/mach-shmobile/board-lager-reference.c   |    2 +-
 arch/arm/mach-shmobile/board-lager.c             |    2 +-
 arch/arm/mach-shmobile/include/mach/r8a73a4.h    |    2 +-
 arch/arm/mach-shmobile/include/mach/r8a7790.h    |    2 +-
 arch/arm/mach-shmobile/setup-r8a73a4.c           |    4 ++--
 arch/arm/mach-shmobile/setup-r8a7790.c           |    4 ++--
 8 files changed, 10 insertions(+), 10 deletions(-)
