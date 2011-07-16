From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 16 Jul 2011 16:21:37 +0900
Subject: [GIT PULL] Samsung fixes for 3.0
Message-ID: <037c01cc4389$02934c10$07b9e430$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

This is last pull request for v3.0 :)

Please pull Samsung fixes from:
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
s5p-fixes-for-linus

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 620917de59eeb934b9f8cf35cc2d95c1ac8ed0fc:

  Linux 3.0-rc7 (2011-07-11 16:51:52 -0700)

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
s5p-fixes-for-linus

Sangwook Lee (1):
      ARM: SAMSUNG: DMA Cleanup as per sparse

Todd Poynor (1):
      ARM: SAMSUNG: Check NULL return from irq_alloc_generic_chip

 arch/arm/mach-s3c64xx/dma.c              |   14 +++++++-------
 arch/arm/plat-s3c24xx/dma.c              |   12 ++++++------
 arch/arm/plat-samsung/dma.c              |    6 +++---
 arch/arm/plat-samsung/include/plat/dma.h |   21 +++++++++++----------
 arch/arm/plat-samsung/irq-uart.c         |    7 +++++++
 arch/arm/plat-samsung/irq-vic-timer.c    |    7 +++++++
 6 files changed, 41 insertions(+), 26 deletions(-)
