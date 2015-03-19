From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 19 Mar 2015 13:22:11 +0530
Subject: [GIT PULL] DaVinci McASP changes for v4.1
Message-ID: <550A802B.7050201@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.1/mcasp

for you to fetch changes up to 6cfdf55b7746a3b1bc324a9e64abe2f055368e6f:

  ARM: davinci: dm646x: Add interrupt resource for McASPs (2015-03-18 17:19:50 +0530)

----------------------------------------------------------------
This pull request contains cleanups and
non-urgent fixes for DaVinci McASP platform
support code.

----------------------------------------------------------------
Peter Ujfalusi (7):
      ARM: davinci: devices-da8xx: Add resource name for the McASP DMA request
      ARM: davinci: devices-da8xx: Add interrupt resource to McASP structs
      ARM: davinci: devices-da8xx: Clean up and correct the McASP device creation
      ARM: davinci: devices-da8xx: Add support for McASP2 on da830
      ARM: davinci: dm646x: Clean up the McASP DMA resources
      ARM: davinci: irqs: Correct McASP1 TX interrupt definition for DM646x
      ARM: davinci: dm646x: Add interrupt resource for McASPs

 arch/arm/mach-davinci/asp.h               |    7 +++
 arch/arm/mach-davinci/devices-da8xx.c     |   80 ++++++++++++++++++++++++++---
 arch/arm/mach-davinci/dm646x.c            |   24 ++++++---
 arch/arm/mach-davinci/include/mach/irqs.h |    2 +-
 4 files changed, 98 insertions(+), 15 deletions(-)
