From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 18 Sep 2012 07:56:40 +0900
Subject: [GIT PULL] Samsung fixes-3 for v3.6
Message-ID: <05be01cd9527$b35c3480$1a149d80$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Here is second Samsung fixes for v3.6.

This includes using spin_lock_irqsave in clk_set_parent() to avoid spinlock
recursion and fixing wrong definitions.

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
v3.6-samsung-fixes-2

Julia Lawall (1):
      ARM: S3C24xx: delete double assignment

Mandeep Singh Baines (1):
      ARM: SAMSUNG: use spin_lock_irqsave() in clk_set_parent

Peter Senna Tschudin (1):
      ARM: S3C24XX: removes unnecessary semicolon

Seung-Woo Kim (1):
      ARM: EXYNOS: fixed SYSMMU setup definition to mate parameter name

 arch/arm/mach-exynos/include/mach/sysmmu.h |    2 +-
 arch/arm/mach-s3c24xx/mach-h1940.c         |    4 ++--
 arch/arm/plat-samsung/clock.c              |    5 +++--
 3 files changed, 6 insertions(+), 5 deletions(-)
