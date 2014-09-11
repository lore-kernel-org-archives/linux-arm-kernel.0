From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 11 Sep 2014 09:57:24 +0900
Subject: [GIT PULL] Renesas ARM Based SoC PM Cleanups for v3.18
Message-ID: <cover.1410395620.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC PM cleanups for v3.18.


The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-pm-cleanups-for-v3.18

for you to fetch changes up to 834720dbf03819a8b2d0ba5fbe01d008267f9da6:

  ARM: shmobile: armadillo800eva legacy: Use rmobile_add_devices_to_domains() (2014-09-09 11:16:08 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC PM Cleanups for v3.18

* Make domain_devices[] static __initdata
* Add and use rmobile_add_devices_to_domain

----------------------------------------------------------------
Geert Uytterhoeven (5):
      ARM: shmobile: mackerel: Make domain_devices[] static __initdata
      ARM: shmobile: sh7372: Make domain_devices[] static __initdata
      ARM: shmobile: r8a7740: Use rmobile_add_devices_to_domains()
      ARM: shmobile: r8a7740: Clean up pm domain table
      ARM: shmobile: armadillo800eva legacy: Use rmobile_add_devices_to_domains()

 arch/arm/mach-shmobile/board-armadillo800eva.c |  8 ++++++--
 arch/arm/mach-shmobile/board-mackerel.c        |  2 +-
 arch/arm/mach-shmobile/pm-r8a7740.c            | 10 ++++------
 arch/arm/mach-shmobile/setup-r8a7740.c         | 26 +++++++++++++++-----------
 arch/arm/mach-shmobile/setup-sh7372.c          |  2 +-
 5 files changed, 27 insertions(+), 21 deletions(-)
