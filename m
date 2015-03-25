From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 25 Mar 2015 09:43:26 +0900
Subject: [GIT PULL] Third Round of Renesas ARM Based SoC Cleanup for v4.1
Message-ID: <cover.1427243965.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these third round of Renesas ARM based SoC cleanup for v4.1.


This pull requests has minor conflict with "Renesas ARM Based SoC sh7372
SoC Removal Updates for v4.1", tagged as
renesas-sh7372-soc-removal-for-v4.1, which you have already pulled.

The solution is to remove arch/arm/mach-shmobile/pm-sh7372.c.


The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-cleanup3-for-v4.1

for you to fetch changes up to df67a2b72eb6fa205c0954e3f4f416e282e7412b:

  ARM: shmobile: cpuidle: Remove the pointless default driver (2015-03-19 11:02:07 +0900)

----------------------------------------------------------------
Third Round of Renesas ARM Based SoC Cleanup for v4.1

* Remove default cpuidle driver, it does not appear to serve any purpose

----------------------------------------------------------------
Daniel Lezcano (1):
      ARM: shmobile: cpuidle: Remove the pointless default driver

 arch/arm/mach-shmobile/Makefile    |  1 -
 arch/arm/mach-shmobile/common.h    |  9 ---------
 arch/arm/mach-shmobile/cpuidle.c   | 37 -------------------------------------
 arch/arm/mach-shmobile/pm-sh7372.c |  2 +-
 4 files changed, 1 insertion(+), 48 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/cpuidle.c
