From: kgene@kernel.org (Kukjin Kim)
Date: Sat, 24 Oct 2015 06:21:39 +0900
Subject: [GIT PULL 2/5] Late Samsung DT64 update for v4.4
In-Reply-To: <562AA40E.4050407@kernel.org>
References: <562AA40E.4050407@kernel.org>
Message-ID: <562AA4E3.1000001@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-dt64

for you to fetch changes up to c60ce7fe82c46d9480b85858828e3042dfe6c9bf:

  arm64: dts: Add BUS1 instance pinctrl support for exynos7 (2015-10-08
07:18:33 +0900)

----------------------------------------------------------------
Samsung arm64 DT update for v4.4

- add BUS1 instance pinctrl support on exynos7 SoC

----------------------------------------------------------------
Alim Akhtar (1):
      arm64: dts: Add BUS1 instance pinctrl support for exynos7

 arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi | 103
++++++++++++++++++++++++
 arch/arm64/boot/dts/exynos/exynos7.dtsi         |   7 ++
 2 files changed, 110 insertions(+)
