From: horms@verge.net.au (Simon Horman)
Date: Wed,  7 Nov 2012 17:34:54 +0900
Subject: [GIT PULL] Renesas ARM-based SoC for v3.8 #2
Message-ID: <1352277298-23312-1-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

please consider the following SoC enhancements for 3.8.

This series is based on the previous SoC series that I sent on Tuesday
and was merged later that day: [GIT PULL v4] Renesas ARM-based SoC for v3.8

----------------------------------------------------------------
The following changes since commit 86bc52ef4373be64867b56f3a9e30cbabf64e0dd:

  ARM: shmobile: r8a7740: Enable PMU (2012-11-06 13:47:24 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git soc

for you to fetch changes up to 9d69f5b87e7f6df51ad2a70557474093de934a8c:

  ARM: shmobile: r8a7779: add USB OHCI clock support (2012-11-07 17:11:48 +0900)

----------------------------------------------------------------
Kuninori Morimoto (4):
      ARM: shmobile: r8a7779: PFC rename PENCx -> USB_PENCx
      ARM: shmobile: r8a7740: add USB24 clock explain
      ARM: shmobile: r8a7779: add USB EHCI clock support
      ARM: shmobile: r8a7779: add USB OHCI clock support

 arch/arm/mach-shmobile/clock-r8a7740.c        |   16 ++++++++++++++++
 arch/arm/mach-shmobile/clock-r8a7779.c        |    7 +++++++
 arch/arm/mach-shmobile/include/mach/r8a7779.h |    2 +-
 arch/arm/mach-shmobile/pfc-r8a7779.c          |   16 ++++++++--------
 4 files changed, 32 insertions(+), 9 deletions(-)
