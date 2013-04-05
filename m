From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  5 Apr 2013 15:12:01 +0900
Subject: [GIT PULL] Renesas ARM r8a7778 SoC update for v3.10
Message-ID: <1365142324-7286-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

The following changes since commit 8585deb18580d04209a2986430aa0959ef38fce2:

  ARM: shmobile: r8a7790 SoC 64-bit DT support (2013-04-02 11:02:21 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas tags/renesas-soc-r8a7778-for-v3.10

for you to fetch changes up to 524219146a89aee5366326c225ccd71231419d89:

  ARM: shmobile: R8A7778: add Ether support (2013-04-05 10:57:05 +0900)

----------------------------------------------------------------
Renesas ARM r8a7778 SoC update for v3.10

Update to the r8a7778 SoC:
* Add SH Ethernet support
* Add r8a7778_init_irq_extpin() to allow configuration of IRQ0 - IRQ3
  - This is a requirement for SMSC ethernet support
* Cleanup: remove PLATFORM_INFO macro

This pull request is based on:
git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas renesas-soc2-for-v3.10

----------------------------------------------------------------
Kuninori Morimoto (2):
      ARM: shmobile: r8a7778: remove pointless PLATFORM_INFO()
      ARM: shmobile: r8a7778: add r8a7778_init_irq_extpin()

Sergei Shtylyov (1):
      ARM: shmobile: R8A7778: add Ether support

 arch/arm/mach-shmobile/clock-r8a7778.c        |    3 +
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    4 ++
 arch/arm/mach-shmobile/setup-r8a7778.c        |   83 ++++++++++++++++++++-----
 3 files changed, 74 insertions(+), 16 deletions(-)
