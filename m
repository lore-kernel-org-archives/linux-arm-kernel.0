From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 24 Feb 2016 10:20:50 +0900
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Cleanup for v4.6
Message-ID: <cover.1456275967.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC cleanups for v4.6.

This pull request is based on "Renesas ARM Based SoC Fixes for v4.5",
tagged as renesas-soc-fixes-for-v4.5, which I have already sent a
pull-request for.

The reason for that base is that the SCU cleanup depends on a change
in the fixes pull request.


The following changes since commit 901c5ffaaed117a38be9d0c29247c4888d6c8636:

  ARM: shmobile: Remove shmobile_boot_arg (2016-02-17 18:27:21 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-cleanup2-for-v4.6

for you to fetch changes up to cf77db5165b606fca7d1d59735528ee43202392e:

  ARM: shmobile: Kconfig: Get rid of old comment (2016-02-17 21:24:29 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Cleanup for v4.6

* Remove stale comment from Kconfig
* Consolidate SCU mapping code

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ARM: shmobile: Consolidate SCU mapping code

Magnus Damm (1):
      ARM: shmobile: Kconfig: Get rid of old comment

 arch/arm/mach-shmobile/Kconfig       |  2 --
 arch/arm/mach-shmobile/common.h      |  5 ++---
 arch/arm/mach-shmobile/platsmp-scu.c | 10 +++++++---
 arch/arm/mach-shmobile/smp-emev2.c   |  3 +--
 arch/arm/mach-shmobile/smp-r8a7779.c |  3 +--
 arch/arm/mach-shmobile/smp-sh73a0.c  |  3 +--
 6 files changed, 12 insertions(+), 14 deletions(-)
