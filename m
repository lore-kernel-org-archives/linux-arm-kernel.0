From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 10 Apr 2013 00:23:37 +0900
Subject: [GIT PULL] Samsung fixes-2 for v3.9
Message-ID: <51643279.7050200@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 31880c37c11e28cb81c70757e38392b42e695dc6:

   Linux 3.9-rc6 (2013-04-07 20:49:54 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-fixes-for-v3.9

for you to fetch changes up to 646dd2f0a980949b05042792fbadd72b735c3eda:

   ARM: S3C24XX: Fix interrupt pending register offset of the EINT 
controller (2013-04-10 00:09:30 +0900)

----------------------------------------------------------------
samsung fixes can support s3c24xx for v3.9

----------------------------------------------------------------
Sylwester Nawrocki (2):
       ARM: S3C24XX: Correct NR_IRQS definition for s3c2440
       ARM: S3C24XX: Fix interrupt pending register offset of the EINT 
controller

  arch/arm/mach-s3c24xx/include/mach/irqs.h | 4 +---
  arch/arm/mach-s3c24xx/irq.c               | 2 +-
  2 files changed, 2 insertions(+), 4 deletions(-)
