From: vikas.sajjan@samsung.com (Vikas Sajjan)
Date: Mon, 28 Jul 2014 18:07:58 +0530
Subject: [RESEND][PATCH 0/2] Add support to get PMU address via DT for
 exynos5260
Message-ID: <1406551080-14821-1-git-send-email-vikas.sajjan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rebased on kgene tree for-next branch
https://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git/log/?h=for-next

Vikas Sajjan (2):
  ARM: DTS: Add PMU DT node for exynos5260 SoC
  ARM: EXYNOS: Add exynos5260 PMU compatible string to DT match table

 .../devicetree/bindings/arm/samsung/pmu.txt        |    1 +
 arch/arm/boot/dts/exynos5260.dtsi                  |    5 +++++
 arch/arm/mach-exynos/exynos.c                      |    1 +
 3 files changed, 7 insertions(+)

-- 
1.7.9.5
