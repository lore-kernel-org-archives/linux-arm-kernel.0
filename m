From: kgene@kernel.org (Kukjin Kim)
Date: Sat, 17 Oct 2015 08:30:34 +0900
Subject: [GIT PULL] Samsung 2nd fixes for v4.3
Message-ID: <5621889A.3020301@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd, Olof, Kevin

Here is 2nd Samsung fixes for v4.3 and it is including fix of exynos
thermal driver with exynos thermal driver maintainer(Lukasz)'s ack.

Please pull.

Thanks,
Kukjin


The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-fixes-2

for you to fetch changes up to b28fec1324bf8f5010d2c3c5d57db4115bda66d4:

  thermal: exynos: Fix register read in TMU (2015-10-17 08:08:56 +0900)

----------------------------------------------------------------
Samsung 2nd fixes for v4.3

- fix SOC detection of exynos thermal on exynos5260
- fix audio card detection on Peach boards
- fix double of_node_put() when parsing child power domains

----------------------------------------------------------------
Alim Akhtar (1):
      ARM: dts: Fix audio card detection on Peach boards

Krzysztof Kozlowski (1):
      ARM: EXYNOS: Fix double of_node_put() when parsing child power domains

Sudip Mukherjee (1):
      thermal: exynos: Fix register read in TMU

 arch/arm/boot/dts/exynos5420-peach-pit.dts | 5 +++++
 arch/arm/boot/dts/exynos5800-peach-pi.dts  | 5 +++++
 arch/arm/mach-exynos/pm_domains.c          | 8 +++-----
 drivers/thermal/samsung/exynos_tmu.c       | 2 +-
 4 files changed, 14 insertions(+), 6 deletions(-)
