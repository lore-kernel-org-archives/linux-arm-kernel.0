From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 30 Aug 2010 16:05:42 +0800
Subject: [GIT PULL] pxa fixes for 2.6.36-rc3
Message-ID: <AANLkTinObjyGTgMudJzWwZFKDeij_Y-8nJ2qA-NN-zvb@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2bfc96a127bc1cc94d26bfaa40159966064f9c8c:
  Linus Torvalds (1):
        Linux 2.6.36-rc3

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git fix

Axel Lin (1):
      ARM: pxa: fix CI_HSYNC and CI_VSYNC MFP defines for pxa300

Eric Miao (1):
      ARM: pxa: remove __init from cpufreq_driver->init()

Marek Vasut (1):
      ARM: pxa168fb: fix section mismatch

Uwe Kleine-K?nig (1):
      ARM: pxa: Make id const in pwm_probe()

 arch/arm/mach-pxa/cpufreq-pxa2xx.c          |    2 +-
 arch/arm/mach-pxa/cpufreq-pxa3xx.c          |    2 +-
 arch/arm/mach-pxa/include/mach/mfp-pxa300.h |    4 ++--
 arch/arm/plat-pxa/pwm.c                     |    2 +-
 drivers/video/pxa168fb.c                    |    6 +++---
 5 files changed, 8 insertions(+), 8 deletions(-)
