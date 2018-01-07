From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun,  7 Jan 2018 12:36:22 +0100
Subject: [GIT PULL 3/4] soc: samsung: Stuff for v4.16
In-Reply-To: <20180107113625.15488-1-krzk@kernel.org>
References: <20180107113625.15488-1-krzk@kernel.org>
Message-ID: <20180107113625.15488-2-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-4.16-2

for you to fetch changes up to 06512c539ff1d6d008d5e8ab9d6f5f6405972f53:

  soc: samsung: Add SPDX license identifiers (2018-01-03 18:45:15 +0100)

----------------------------------------------------------------
Samsung soc drivers changes for v4.16

Add SPDX license identifiers.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      soc: samsung: Add SPDX license identifiers

 drivers/soc/samsung/Kconfig          |  1 +
 drivers/soc/samsung/Makefile         |  1 +
 drivers/soc/samsung/exynos-pmu.c     | 16 ++++++----------
 drivers/soc/samsung/exynos-pmu.h     |  5 +----
 drivers/soc/samsung/exynos3250-pmu.c | 16 ++++++----------
 drivers/soc/samsung/exynos4-pmu.c    | 16 ++++++----------
 drivers/soc/samsung/exynos5250-pmu.c | 16 ++++++----------
 drivers/soc/samsung/exynos5420-pmu.c | 16 ++++++----------
 drivers/soc/samsung/pm_domains.c     | 24 ++++++++++--------------
 9 files changed, 43 insertions(+), 68 deletions(-)
