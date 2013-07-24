From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 24 Jul 2013 12:37:15 +0900
Subject: [PATCH 00/08] ARM: shmobile: Get rid of <mach/hardware.h>
Message-ID: <20130724033715.30567.82782.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: Get rid of <mach/hardware.h>

[PATCH 01/08] ARM: shmobile: Remove sh73a0 use of <mach/hardware.h>
[PATCH 02/08] ARM: shmobile: Remove sh7372 use of <mach/hardware.h>
[PATCH 03/08] ARM: shmobile: Remove EMEV2 use of <mach/hardware.h>
[PATCH 04/08] ARM: shmobile: Remove r8a7779 use of <mach/hardware.h>
[PATCH 05/08] ARM: shmobile: Remove AG5EVM use of <mach/hardware.h>
[PATCH 06/08] ARM: shmobile: Remove Kota2 use of <mach/hardware.h>
[PATCH 07/08] ARM: shmobile: Remove Marzen use of <mach/hardware.h>
[PATCH 08/08] ARM: shmobile: Remove include <mach/hardware.h>

The <mach/hardware.h> file is empty anyway, so let's stop using it.

Feel free to drop Kota2 or AG5EVM patches in case those boards get
removed before this series is applied.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Built on top of renesas-devel-20130723

 arch/arm/mach-shmobile/board-ag5evm.c          |    1 -
 arch/arm/mach-shmobile/board-kota2.c           |    1 -
 arch/arm/mach-shmobile/board-marzen.c          |    1 -
 arch/arm/mach-shmobile/include/mach/hardware.h |    4 ----
 arch/arm/mach-shmobile/setup-emev2.c           |    1 -
 arch/arm/mach-shmobile/setup-r8a7779.c         |    1 -
 arch/arm/mach-shmobile/setup-sh7372.c          |    1 -
 arch/arm/mach-shmobile/setup-sh73a0.c          |    1 -
 8 files changed, 11 deletions(-)
