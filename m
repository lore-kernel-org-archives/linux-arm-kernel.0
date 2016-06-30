From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 30 Jun 2016 09:51:14 +0200
Subject: [GIT PULL 3/4] ARM: dts: exynos: MFC driver topic branch for v4.8,
 part 2
In-Reply-To: <1467273075-13747-1-git-send-email-k.kozlowski@samsung.com>
References: <1467273075-13747-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1467273075-13747-4-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Continuation of previous topic branch (tag tags/samsung-drivers-exynos-mfc-4.8).
DTS changes only but this depends on previous work.

Best regards,
Krzysztof


The following changes since commit 96167bd37dd604cbba0aed341765dda8556405b2:

  ARM: dts: exynos: Enable MFC device on Exynos4412 Odroid boards (2016-06-06 09:30:43 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-exynos-mfc-4.8-2

for you to fetch changes up to 9f7d27fa1b0b3685471a1a34223a3475943f53e4:

  ARM: dts: exynos: enable MFC device for all boards (2016-06-08 09:46:00 +0200)

----------------------------------------------------------------
Topic branch for Exynos MFC changes for v4.8, part 2:

Replace hardcoded reserved memory ranges with auto-allocated ones
and enable MFC for all boards.

----------------------------------------------------------------
Marek Szyprowski (3):
      ARM: dts: exynos: replace hardcoded reserved memory ranges with auto-allocated ones
      ARM: dts: exynos: move MFC reserved memory regions from boards to .dtsi
      ARM: dts: exynos: enable MFC device for all boards

 arch/arm/boot/dts/exynos-mfc-reserved-memory.dtsi  | 14 ++++++++++----
 arch/arm/boot/dts/exynos3250-rinato.dts            |  4 ----
 arch/arm/boot/dts/exynos3250.dtsi                  |  1 -
 arch/arm/boot/dts/exynos4.dtsi                     |  1 -
 arch/arm/boot/dts/exynos4210-origen.dts            |  5 -----
 arch/arm/boot/dts/exynos4210-smdkv310.dts          |  5 -----
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |  5 -----
 arch/arm/boot/dts/exynos4412-origen.dts            |  5 -----
 arch/arm/boot/dts/exynos4412-smdk4412.dts          |  5 -----
 arch/arm/boot/dts/exynos5250-arndale.dts           |  4 ----
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |  4 ----
 arch/arm/boot/dts/exynos5250-spring.dts            |  4 ----
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |  4 ----
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |  4 ----
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |  4 ----
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  4 ----
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |  4 ----
 17 files changed, 10 insertions(+), 67 deletions(-)
