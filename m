From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:22:56 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Drivers Updates for v4.7
Message-ID: <cover.1459732456.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC drivers updates for v4.7.


The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-drivers-for-v4.7

for you to fetch changes up to cd89841fc6dbb6dc11aa113769f39dcd30be720f:

  ARM: shmobile: timer: Drop support for Cortex A8 (2016-03-28 09:01:31 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Drivers Updates for v4.7

Loop delay calculation updates:
* Remove check for no longer supported Cortex A8 cores
* Correct short calculation of delay

----------------------------------------------------------------
Geert Uytterhoeven (2):
      ARM: shmobile: timer: Fix preset_lpj leading to too short delays
      ARM: shmobile: timer: Drop support for Cortex A8

 arch/arm/mach-shmobile/timer.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)
