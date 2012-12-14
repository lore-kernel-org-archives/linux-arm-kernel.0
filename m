From: jon-hunter@ti.com (Jon Hunter)
Date: Fri, 14 Dec 2012 10:45:31 -0600
Subject: [GIT PULL] ARM: OMAP2+: Timer build warnings fixes for v3.8-rc
Message-ID: <50CB57AB.8080503@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 698d601224824bc1a5bf17f3d86be902e2aabff0:

  Merge tag 'drivers' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc (2012-12-13 10:59:11 -0800)

are available in the git repository at:


  git://github.com/jonhunter/linux.git fixes-timer-build

for you to fetch changes up to bf85f205d95eb223e849914101e0db1a5a576a3c:

  ARM: OMAP2+: Fix sparse warnings in timer.c (2012-12-14 10:14:55 -0600)

----------------------------------------------------------------
Fixes for a few timer warnings observed with different kernel
configurations for OMAP2+ devices.

I have dropped the patch to fix a build error for OMAP4 in the
timer code as Olof already has this fix merged.
----------------------------------------------------------------

Jon Hunter (2):
      ARM: OMAP2+: Fix realtime_counter_init warning in timer.c
      ARM: AM335x: Fix warning in timer.c

Vaibhav Hiremath (1):
      ARM: OMAP2+: Fix sparse warnings in timer.c

 arch/arm/mach-omap2/Kconfig |    3 ++-
 arch/arm/mach-omap2/timer.c |    6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)
