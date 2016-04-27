From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 27 Apr 2016 11:10:55 +0200
Subject: [GIT PULL 2/3] ARM: dts: exynos: Fixup for SROM controller (v4.7)
In-Reply-To: <1461748256-4394-1-git-send-email-k.kozlowski@samsung.com>
References: <1461748256-4394-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1461748256-4394-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The DTS changes for SROM controller (pull 3/3 here) was pulled during
previous cycle. The SROM controller itself was delayed due to
late comments. These late comments introduced changes in the bindings
which now have to be fixed before merging drivers/memory commits.

Best regards,
Krzysztof


The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  kernel.org:/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-exynos-srom-fixup-4.7

for you to fetch changes up to 4d7820b0465a78e6c85a74474b89fb4ab84768ba:

  ARM: dts: change SROM node compatible from generic to model specific (2016-04-18 14:18:31 +0200)

----------------------------------------------------------------
DeviceTree changes for new SROM controller driver reached mainline
some time ago, before the driver was accepted (due to very late
comments). However, after these late comments, the driver expects
different bindings so we need to fix the DTS.

----------------------------------------------------------------
Pankaj Dubey (1):
      ARM: dts: change SROM node compatible from generic to model specific

 arch/arm/boot/dts/exynos4.dtsi            | 4 ++--
 arch/arm/boot/dts/exynos5.dtsi            | 4 ++--
 arch/arm/boot/dts/exynos5410-smdk5410.dts | 2 +-
 arch/arm/boot/dts/exynos5410.dtsi         | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)
