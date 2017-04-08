From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat,  8 Apr 2017 16:10:01 +0200
Subject: [GIT PULL 2/5] ARM: soc: samsung: exynos for v4.12
In-Reply-To: <20170408141004.386-1-krzk@kernel.org>
References: <20170408141004.386-1-krzk@kernel.org>
Message-ID: <20170408141004.386-3-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-4.12

for you to fetch changes up to a0ebf66267ebab093cd7e230e70d29249768d249:

  soc: samsung: Do not build ARMv7 PMU drivers on ARMv8 (2017-03-21 19:03:39 +0200)

----------------------------------------------------------------
Samsung SoC drivers update for v4.12 - split building of the PMU driver between
ARMv7 and ARMv8.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      soc: samsung: Do not build ARMv7 PMU drivers on ARMv8

 drivers/soc/samsung/Kconfig      |  8 +++++++-
 drivers/soc/samsung/Makefile     |  4 +++-
 drivers/soc/samsung/exynos-pmu.c | 22 ++++++++++++++++------
 drivers/soc/samsung/exynos-pmu.h |  3 +++
 4 files changed, 29 insertions(+), 8 deletions(-)
