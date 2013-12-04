From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 5 Dec 2013 03:58:17 +0530
Subject: [GIT PULL] DaVinci fixes for v3.13-rc3
Message-ID: <529FAC81.6090102@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-fixes-for-v3.13-rc3

for you to fetch changes up to ee880dbd1688c99084052c7890246c1e16c89820:

  ARM: davinci: Fix McASP mem resource names (2013-12-05 03:02:20 +0530)

----------------------------------------------------------------
This pull request includes a patch
to align platform code to driver's
usage of platform_get_resource_byname()

This is needed to start successfully probing
audio again. The regression was introduced
in v3.13 merge window.

----------------------------------------------------------------
Peter Ujfalusi (1):
      ARM: davinci: Fix McASP mem resource names

 arch/arm/mach-davinci/devices-da8xx.c |    4 ++--
 arch/arm/mach-davinci/dm355.c         |    1 +
 arch/arm/mach-davinci/dm365.c         |    1 +
 arch/arm/mach-davinci/dm644x.c        |    1 +
 arch/arm/mach-davinci/dm646x.c        |    4 ++--
 5 files changed, 7 insertions(+), 4 deletions(-)
