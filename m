From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Dec 2014 10:47:06 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Updates for v3.20
Message-ID: <cover.1419810196.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC updates for v3.20.


The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-for-v3.20

for you to fetch changes up to 39695882d3d642a73bca551e682426e4e3bcd158:

  ARM: shmobile: r8a73a4: Multiplatform support (2014-12-21 17:11:22 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Updates for v3.20

* Multiplatform support for r8a73a4
* No TWD setup in C for Multiplatform on r8a7779
* Fix is_e2 warning in generic R-Car Gen2 SoC setup code
* Add missing Add missing legacy INTCA0 clock for irqpin module on sh73a0

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ARM: shmobile: sh73a0 legacy/reference: Add missing INTCA0 clock for irqpin module

Magnus Damm (2):
      ARM: shmobile: Fix is_e2 warning
      ARM: shmobile: r8a7779: No TWD setup in C for Multiplatform

Ulrich Hecht (1):
      ARM: shmobile: r8a73a4: Multiplatform support

 arch/arm/mach-shmobile/Kconfig           |  5 +++++
 arch/arm/mach-shmobile/clock-sh73a0.c    | 10 ++++++++++
 arch/arm/mach-shmobile/setup-rcar-gen2.c |  4 +---
 arch/arm/mach-shmobile/smp-r8a7779.c     |  2 +-
 4 files changed, 17 insertions(+), 4 deletions(-)
