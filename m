From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue,  6 Mar 2018 19:01:21 +0100
Subject: [GIT PULL 1/4] soc: samsung: Driver changes for v4.17
In-Reply-To: <20180306180124.8987-1-krzk@kernel.org>
References: <20180306180124.8987-1-krzk@kernel.org>
Message-ID: <20180306180124.8987-2-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-4.17

for you to fetch changes up to 7353c54620732797dcc3b4b1fc6f3cc0c0d9b6ef:

  soc: samsung: pmu: Populate children syscon nodes (2018-02-13 18:47:25 +0100)

----------------------------------------------------------------
Samsung soc drivers changes for v4.17

1. Add SPDX license identifiers.
2. Populate children syscon nodes in PMU driver to properly model HW in
   DeviceTree.

----------------------------------------------------------------
Krzysztof Kozlowski (3):
      memory: samsung: Add SPDX license identifiers
      soc: samsung: Add SPDX license identifiers to headers
      soc: samsung: pmu: Populate children syscon nodes

 Documentation/devicetree/bindings/arm/samsung/pmu.txt |  6 ++++++
 drivers/memory/samsung/Kconfig                        |  1 +
 drivers/memory/samsung/Makefile                       |  1 +
 drivers/memory/samsung/exynos-srom.c                  | 18 +++++++-----------
 drivers/memory/samsung/exynos-srom.h                  |  7 ++-----
 drivers/soc/samsung/exynos-pmu.c                      |  7 +++++++
 include/linux/soc/samsung/exynos-pmu.h                |  5 +----
 include/linux/soc/samsung/exynos-regs-pmu.h           |  6 +-----
 8 files changed, 26 insertions(+), 25 deletions(-)
