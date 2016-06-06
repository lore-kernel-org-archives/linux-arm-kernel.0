From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 06 Jun 2016 14:25:28 +0200
Subject: [GIT PULL 3/8] ARM: exynos: Drivers for v4.8
In-Reply-To: <1465215933-22709-1-git-send-email-k.kozlowski@samsung.com>
References: <1465215933-22709-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1465215933-22709-4-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-4.8

for you to fetch changes up to 9479f7cc91879c6ba75e70da41c4c9fe7842b342:

  soc: samsung: pm_domains: Enable COMPILE_TEST for build coverage (2016-05-30 09:12:57 +0200)

----------------------------------------------------------------
Samsung drivers/soc update for v4.8:
1. Move the power domain driver from arm/mach-exynos and prepare
   for supporting ARMv8.
2. Add COMPILE_TEST.

----------------------------------------------------------------
Krzysztof Kozlowski (3):
      ARM: EXYNOS: Move pm_domains driver to drivers/soc/samsung
      soc: samsung: pm_domains: Prepare for supporting ARMv8 Exynos
      soc: samsung: pm_domains: Enable COMPILE_TEST for build coverage

 arch/arm/mach-exynos/Kconfig                       |  1 +
 arch/arm/mach-exynos/Makefile                      |  1 -
 drivers/soc/samsung/Kconfig                        |  4 +++
 drivers/soc/samsung/Makefile                       |  1 +
 .../soc/samsung}/pm_domains.c                      | 34 ++++++++++++++++++----
 5 files changed, 34 insertions(+), 7 deletions(-)
 rename {arch/arm/mach-exynos => drivers/soc/samsung}/pm_domains.c (85%)
