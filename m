From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 3 Nov 2016 16:48:44 +0530
Subject: [GIT PULL] DaVinci fix for v4.9-rc
Message-ID: <f57fbfde-89ff-fdac-2a04-e8a4788b4ee5@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit a909d3e636995ba7c349e2ca5dbb528154d4ac30:

  Linux 4.9-rc3 (2016-10-29 13:52:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-fixes-for-v4.9

for you to fetch changes up to 36173c2d023bad4dbad6ed0e6e886fde10ec8f2f:

  ARM: davinci: da850: Fix pwm name matching (2016-11-01 15:30:03 +0530)

----------------------------------------------------------------
This patch enables usage of multiple eCAP and eHRPWM devices
using PWM sysfs entries.

Without this patch, creation of multiple entries fails due
to name clash.

This is not a v4.9 regression but it will be nice to fix it
soon.

----------------------------------------------------------------
David Lechner (1):
      ARM: davinci: da850: Fix pwm name matching

 arch/arm/mach-davinci/da850.c    | 48 +++++++++++++++++++++++++++++++++++++---
 arch/arm/mach-davinci/da8xx-dt.c | 10 ++++-----
 2 files changed, 50 insertions(+), 8 deletions(-)
