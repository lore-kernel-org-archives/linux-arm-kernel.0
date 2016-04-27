From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 27 Apr 2016 11:10:54 +0200
Subject: [GIT PULL 1/3] ARM: dts: exynos: Secound round of DTS for v4.7
In-Reply-To: <1461748256-4394-1-git-send-email-k.kozlowski@samsung.com>
References: <1461748256-4394-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1461748256-4394-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Few DTS changes, nothing special.

Best regards,
Krzysztof


The following changes since commit 06e520c4f067e7284fded10656acca924123c58e:

  ARM: dts: s5p: Fix DTC unit name warnings in SMDKv210 board (2016-04-13 11:14:52 +0200)

are available in the git repository at:

  kernel.org:/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.7-2

for you to fetch changes up to 8691f91b5f5b8687515654b065ebca447ba8b13a:

  ARM: dts: exynos: Enable PRNG and SSS for all Exynos4 devices (2016-04-27 10:14:12 +0200)

----------------------------------------------------------------
Secound round of Samsung Device Tree updates and improvements for v4.7:
1. Cleanup regulator bindings on Exynos5420 boards.
2. Support MIC bypass in display path for Exynos5420.
3. Enable PRNG and SSS for all Exynos4 devices.

----------------------------------------------------------------
Chanho Park (1):
      ARM: dts: exynos: Add exynos5420-fimd compatible

Krzysztof Kozlowski (2):
      ARM: dts: exynos: Remove unsupported s2mps11 regulator bindings from Exynos5420 boards
      ARM: dts: exynos: Enable PRNG and SSS for all Exynos4 devices

 arch/arm/boot/dts/exynos4.dtsi                     | 2 --
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    | 4 ----
 arch/arm/boot/dts/exynos4412-trats2.dts            | 8 --------
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      | 7 -------
 arch/arm/boot/dts/exynos5420-smdk5420.dts          | 7 -------
 arch/arm/boot/dts/exynos5420.dtsi                  | 1 +
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 7 -------
 7 files changed, 1 insertion(+), 35 deletions(-)
