From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri,  9 Jun 2017 18:42:46 +0200
Subject: [GIT PULL 4/4] ARM: defconfig: exynos: Defconfig for v4.13
In-Reply-To: <20170609164249.1656-1-krzk@kernel.org>
References: <20170609164249.1656-1-krzk@kernel.org>
Message-ID: <20170609164249.1656-2-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-defconfig-4.13

for you to fetch changes up to f33160d14f959991e88074fc419546c8d62312a5:

  ARM: multi_v7_defconfig: Enable Exynos RNG and user-space crypto API (2017-05-15 19:04:10 +0200)

----------------------------------------------------------------
Samsung defconfig ARM update for v4.13:
1. Enable Exynos PRNG along with user-space crypto API.

----------------------------------------------------------------
Krzysztof Kozlowski (2):
      ARM: exynos_defconfig: Enable Exynos RNG and user-space crypto API
      ARM: multi_v7_defconfig: Enable Exynos RNG and user-space crypto API

 arch/arm/configs/exynos_defconfig   | 6 ++++++
 arch/arm/configs/multi_v7_defconfig | 6 ++++++
 2 files changed, 12 insertions(+)
