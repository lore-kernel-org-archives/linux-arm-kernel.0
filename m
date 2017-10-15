From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 15 Oct 2017 09:48:22 +0200
Subject: [GIT PULL 2/4] soc: samsung: Pull for v4.15
In-Reply-To: <20171015074825.11338-1-krzk@kernel.org>
References: <20171015074825.11338-1-krzk@kernel.org>
Message-ID: <20171015074825.11338-3-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-4.15

for you to fetch changes up to c40610198f35e8264f9175dafe74db6288a07eda:

  soc: samsung: Remove Exynos4212 related dead code (2017-10-08 14:17:13 +0200)

----------------------------------------------------------------
Samsung soc drivers changes for v4.15

Remove of Exynos4212 related dead code (no more support for this SoC).

----------------------------------------------------------------
Marek Szyprowski (1):
      soc: samsung: Remove Exynos4212 related dead code

 Documentation/devicetree/bindings/arm/samsung/pmu.txt |  1 -
 drivers/soc/samsung/exynos-pmu.c                      |  9 ---------
 drivers/soc/samsung/exynos-pmu.h                      |  2 --
 drivers/soc/samsung/exynos4-pmu.c                     | 13 ++-----------
 4 files changed, 2 insertions(+), 23 deletions(-)
