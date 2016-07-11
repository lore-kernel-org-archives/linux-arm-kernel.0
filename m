From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 11 Jul 2016 18:41:15 +0200
Subject: [GIT PULL 1/4]  ARM: exynos: Drivers for v4.8, last round
Message-ID: <1468255278-32162-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Last round of commits for v4.8. On top of previous tag.

Best regards,
Krzysztof


The following changes since commit 187364b6fcabb9f4bfefcb62fab4fcda019b5810:

  cpufreq: s5pv210: use relaxed IO accesors (2016-06-22 14:00:21 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-4.8-3

for you to fetch changes up to aec6341e2ac76ea8703642e83535f216b8866162:

  soc: samsung: pmu: Constify arrays with PMU data (2016-07-06 10:35:45 +0200)

----------------------------------------------------------------
Samsung drivers/soc update for v4.8, part 3
1. Fix size of allocation for Exynos SROM registers (too much was allocated).
2. Constify fix.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      soc: samsung: pmu: Constify arrays with PMU data

Seung-Woo Kim (1):
      memory: samsung: exynos-srom: Fix wrong count of registers

 drivers/memory/samsung/exynos-srom.c | 2 +-
 drivers/soc/samsung/exynos3250-pmu.c | 2 +-
 drivers/soc/samsung/exynos5420-pmu.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
