From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 03 Mar 2014 09:51:53 +0000 (GMT)
Subject: [GIT PULL 2/6] Samsung drivers for v3.15
Message-ID: <15399641.260291393840311352.JavaMail.weblogic@epml16>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git tags/samsung-drivers

for you to fetch changes up to a83784859ccde07ebdc3a7acfbb2f74cb6c75a80:

  irqchip: exynos-combiner: call handle_bad_irq directly (2014-02-14 07:27:40 +0900)

----------------------------------------------------------------
Samsung drivers update for v3.15
- remove inclusion from exynos_mct.c
- remove inclusion from exynos-combiner.c
  and use calling handle_bad_irq() instead of do_bad_IRQ()

----------------------------------------------------------------
Pankaj Dubey (2):
      clocksource: exynos_mct: remove unwanted header file inclusion
      irqchip: exynos-combiner: call handle_bad_irq directly

drivers/clocksource/exynos_mct.c  |    2 --
drivers/irqchip/exynos-combiner.c |    3 +--
2 files changed, 1 insertion(+), 4 deletions(-) 
