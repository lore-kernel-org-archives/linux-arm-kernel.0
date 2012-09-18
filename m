From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 18 Sep 2012 22:54:34 +0930
Subject: [GIT PULL] Samsung fixes-3 for v3.6
Message-ID: <50587612.4030304@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

This is re-sending Samsung fixes-3 I talked to Olof before.

The branch is including two commits are using spin_lock_{irqsave, 
irqrestore} in clk_set_parent() and clk_set_rate() to avoid spinlock 
recursion/locking.

If any problems, please kindly let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 4cbe5a555fa58a79b6ecbb6c531b8bab0650778d:

   Linux 3.6-rc4 (2012-09-01 10:39:58 -0700)

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
v3.6-samsung-fixes-3

Mandeep Singh Baines (1):
       ARM: SAMSUNG: use spin_lock_irqsave() in clk_set_parent

Tushar Behera (1):
       ARM: SAMSUNG: Use spin_lock_{irqsave,irqrestore} in clk_set_rate

  arch/arm/plat-samsung/clock.c |   10 ++++++----
  1 files changed, 6 insertions(+), 4 deletions(-)
