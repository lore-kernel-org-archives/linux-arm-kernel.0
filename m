From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 08 Oct 2010 14:55:21 +0900
Subject: [GIT PULL] Samsung fixes for 2.6.36
Message-ID: <00e101cb66ad$6788e030$369aa090$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull Samsung fixes from:

git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
s5p-fixes-for-linus

These things are for bug fix on 2.6.36.
If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.


The following changes since commit cb655d0f3d57c23db51b981648e452988c0223f9:

  Linux 2.6.36-rc7 (2010-10-06 13:39:52 -0700)

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
s5p-fixes-for-linus

Kukjin Kim (1):
      ARM: SAMSUNG: Fix build warnings because of unused codes

Marek Szyprowski (1):
      ARM: SAMSUNG: Add a workaround for get_clock() for serial driver

SeungChull Suh (1):
      ARM: S5P: Bug fix on errors of build with CONFIG_PREEMPT_NONE

 arch/arm/mach-s5p6440/cpu.c   |    1 +
 arch/arm/mach-s5p6442/cpu.c   |    1 +
 arch/arm/mach-s5pc100/cpu.c   |    1 +
 arch/arm/mach-s5pv210/clock.c |    5 -----
 arch/arm/mach-s5pv210/cpu.c   |    1 +
 arch/arm/plat-samsung/adc.c   |    1 -
 arch/arm/plat-samsung/clock.c |   27 ++++++++++++++++++++++++++-
 7 files changed, 30 insertions(+), 7 deletions(-)
