From: kgene@kernel.org (Kukjin Kim)
Date: Tue, 04 Aug 2015 16:28:21 +0900
Subject: [GIT PULL 1/5] Samsung non-critical-fixes for v4.3
Message-ID: <55C06995.2030600@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Kevin,

Here is Samsung non-critical-fixes for v4.3.
Please pull.

Thanks,
Kukjin

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-non-critical-1

for you to fetch changes up to 2cc6b813579415c4f627b08a043079bdc5b87a33:

  ARM: EXYNOS: Use IOMEM_ERR_PTR when function returns iomem (2015-07-21
13:19:06 +0900)

----------------------------------------------------------------
Samsung non-critical fixes for v4.3

- fix sparse warning for returning iomem
- fix clock-frequency of display timing0 for exynos3250-rinato

----------------------------------------------------------------
Hyungwon Hwang (1):
      ARM: dts: fix clock-frequency of display timing0 for exynos3250-rinato

Krzysztof Kozlowski (1):
      ARM: EXYNOS: Use IOMEM_ERR_PTR when function returns iomem

 arch/arm/boot/dts/exynos3250-rinato.dts | 2 +-
 arch/arm/mach-exynos/platsmp.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
