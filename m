From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 14 Jan 2011 08:37:13 -0600
Subject: [GIT PULL v2] pxa: patches for v2.6.37-rc
Message-ID: <AANLkTin_LK7MtJiz7e417k4XCumOBq+dnTgLBCe8HYj1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Didn't realize that some of the fixing patches are in my devel branch, sorry
for the noise. Please pull again and let know if there's any issue.

The following changes since commit 581548db3b3c0f6e25b500329eb02e3c72e7acbe:

  Merge branch 'release' of
git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux-2.6
(2011-01-13 11:02:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git devel

Eric Miao (1):
      ARM: pxa: fix recursive calls in pxa_low_gpio_chip

Marek Vasut (4):
      ARM: pxa: fix warning in zeus.c
      ARM: pxa: remove unused variable in clock-pxa3xx.c
      ARM: pxa: use cpu_has_ipr() consistently in irq.c
      ARM: pxa: fix suspend/resume array index miscalculation

Pavel Machek (1):
      ARM: sa1111: fix typo in sa1111_retrigger_lowirq()

Philip Rakity (2):
      ARM: mmp: MMP2 drive strength FAST using wrong value
      ARM: mmp: PXA910 drive strength FAST using wrong value

 arch/arm/common/sa1111.c                    |    2 +-
 arch/arm/mach-mmp/include/mach/mfp-mmp2.h   |    2 +-
 arch/arm/mach-mmp/include/mach/mfp-pxa910.h |    2 +-
 arch/arm/mach-pxa/clock-pxa3xx.c            |    1 -
 arch/arm/mach-pxa/irq.c                     |   49 ++++++++++-----------------
 arch/arm/mach-pxa/zeus.c                    |    4 +-
 6 files changed, 23 insertions(+), 37 deletions(-)
