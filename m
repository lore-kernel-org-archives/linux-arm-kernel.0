From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  4 Nov 2014 10:49:56 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Runtime PM Updates for v3.19
Message-ID: <cover.1415058794.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC runtime PM updates for v3.19.


The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-runtime-pm-for-v3.19

for you to fetch changes up to dc4470e177973feedd82596969d86468a1695b1e:

  ARM: shmobile: r8a7740: Add A3SM pm domain support (2014-10-28 08:40:18 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Runtime PM Updates for v3.19

* 8a7740/armadillo800eva legacy PM domain support

----------------------------------------------------------------
Geert Uytterhoeven (11):
      ARM: shmobile: r8a7740: Add missing A3SP pm domain devices
      ARM: shmobile: r8a7740: Add missing A4S pm domain devices
      ARM: shmobile: armadillo800eva legacy: Add missing A3SP pm domain devices
      ARM: shmobile: armadillo800eva legacy: Add missing A4S pm domain devices
      ARM: shmobile: r8a7740: Add A3RV pm domain support
      ARM: shmobile: r8a7740: Add A3SG pm domain support
      ARM: shmobile: r8a7740/armadillo legacy: Add A4MP pm domain support
      ARM: shmobile: r8a7740: Add D4 pm domain support
      ARM: shmobile: r8a7740/armadillo legacy: Add A4R pm domain support
      ARM: shmobile: r8a7740: Add A4SU pm domain support
      ARM: shmobile: r8a7740: Add A3SM pm domain support

 arch/arm/mach-shmobile/board-armadillo800eva.c | 12 ++++++-
 arch/arm/mach-shmobile/pm-r8a7740.c            | 44 +++++++++++++++++++++++---
 arch/arm/mach-shmobile/setup-r8a7740.c         | 11 +++++++
 3 files changed, 62 insertions(+), 5 deletions(-)
