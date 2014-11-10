From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 10 Nov 2014 10:32:34 +0900
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Soc Updates for v3.19
Message-ID: <cover.1415581286.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC soc updates for v3.19.

This pull request is based on the previous round of
such requests, tagged as renesas-soc-for-v3.19,
which I have already sent a pull-request for.


The following changes since commit 3794705aeb318c431c07072f04380c78cc5a84ac:

  ARM: shmobile: Select CONFIG_ZONE_DMA when CONFIG_ARM_LPAE is enabled (2014-10-28 08:43:03 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc2-for-v3.19

for you to fetch changes up to 950a3f0e7dd32c372c9957d5c050b08de7ec9e56:

  ARM: shmobile: Enable PCI domains for R-Car Gen2 devices (2014-11-05 14:50:17 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Soc Updates for v3.19

* Enable PCI domains for R-Car Gen2 devices
* Make APMU resource code SoC-specific

----------------------------------------------------------------
Hisashi Nakamura (2):
      ARM: shmobile: Separate APMU resource data into CPU dependant part
      ARM: shmobile: r8a7791: Correct number of CPU cores

Phil Edworthy (1):
      ARM: shmobile: Enable PCI domains for R-Car Gen2 devices

 arch/arm/mach-shmobile/Kconfig        |  1 +
 arch/arm/mach-shmobile/common.h       |  5 -----
 arch/arm/mach-shmobile/platsmp-apmu.c | 27 +++++++++------------------
 arch/arm/mach-shmobile/platsmp-apmu.h | 32 ++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/smp-r8a7790.c  | 16 +++++++++++++++-
 arch/arm/mach-shmobile/smp-r8a7791.c  | 12 +++++++++++-
 6 files changed, 68 insertions(+), 25 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/platsmp-apmu.h
