From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Feb 2014 15:20:06 +0900
Subject: [GIT PULL 0/3] Renesas ARM Based SoC Clean-Ups for v3.15
Message-ID: <cover.1391650702.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

please consider these Renesas ARM Based SoC clean-ups for v3.15.


The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-cleanup-for-v3.15

for you to fetch changes up to d24d1780c340777942061ef3445edcf228e8d35b:

  ARM: shmobile: emev2: Use __initconst for const init definition (2014-02-04 10:24:28 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Clean-Ups for v3.15

* Renesas SoCs (Global)
  - Remove duplicate shmobile_invalidate_start() declaration

* emev2 SoC (Emma Mobile)
  - Use __initconst for const init definition

* r8a7779 SoC (R-Car H1)
  - Remove unused clock constants

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ARM: shmobile: Remove duplicate shmobile_invalidate_start() declaration

Simon Horman (2):
      ARM: shmobile: r8a7779: Remove unused clock constants
      ARM: shmobile: emev2: Use __initconst for const init definition

 arch/arm/mach-shmobile/clock-r8a7779.c       | 7 -------
 arch/arm/mach-shmobile/include/mach/common.h | 1 -
 arch/arm/mach-shmobile/setup-emev2.c         | 2 +-
 3 files changed, 1 insertion(+), 9 deletions(-)
