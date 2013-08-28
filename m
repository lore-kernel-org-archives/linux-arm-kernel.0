From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 28 Aug 2013 10:42:54 +0900
Subject: [GIT PULL 0/2] Third round of Renesas ARM based SoC updates for v3.12
Message-ID: <cover.1377652063.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin, Hi Olof, Hi Arnd,

please consider this third round of Renesas ARM based SoC updates for v3.12.

It is based on renesas-soc-for-v3.12 ("Second Round of ARM based SoC
updates for v3.12") which you have previously pulled.

I apologise that this and other pull requests that I will send today
are rather later in the cycle than I would like. This is primarily due
to a combination of my summer vacation and wanting to let the patches
sit in next for a while.


The following changes since commit d687f4d1993fa046171dbb1ca1970a3172ce11b9:

  ARM: shmobile: r8a7740: Add TPU clock entry for DT platforms (2013-08-06 17:57:09 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc3-for-v3.12

for you to fetch changes up to c223d986b953a4686f2540091f82e44030a50daa:

  ARM: shmobile: r8a7790: Add DU and LVDS clocks (2013-08-22 10:46:46 +0900)

----------------------------------------------------------------
Third round of Renesas ARM based SoC updates for v3.12

* Increased clock coverage for r8a7790 SoC
* Rename DU device in clock lookups list of r8a7779 SoC

----------------------------------------------------------------
Laurent Pinchart (2):
      ARM: shmobile: r8a7779: Rename DU device in clock lookups list
      ARM: shmobile: r8a7790: Add DU and LVDS clocks

 arch/arm/mach-shmobile/clock-r8a7779.c |  2 +-
 arch/arm/mach-shmobile/clock-r8a7790.c | 12 +++++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)
