From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 16 Dec 2013 05:22:36 +0900
Subject: [GIT PULL 5/7] Samsung irq for v3.14
Message-ID: <52AE0F8C.3040408@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-irq

for you to fetch changes up to 9403ac88220d79f8822e22c875ad1ebd7ffbea6f:

   irqchip: exynos-combiner: remove hard-coded irq_base value 
(2013-12-02 07:15:51 +0900)

----------------------------------------------------------------
Samsung irq update for v3.14
- use linear irq domain for exynos-combiner

----------------------------------------------------------------
Chander Kashyap (1):
       irqchip: exynos-combiner: remove hard-coded irq_base value

  drivers/irqchip/exynos-combiner.c | 15 +++------------
  1 file changed, 3 insertions(+), 12 deletions(-)
