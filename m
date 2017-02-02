From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu,  2 Feb 2017 20:30:07 +0200
Subject: [GIT PULL 3/4] ARM: dts: exynos: DT for v4.11, third round
In-Reply-To: <20170202183008.23500-1-krzk@kernel.org>
References: <20170202183008.23500-1-krzk@kernel.org>
Message-ID: <20170202183008.23500-4-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On top of previous pull request.

Best regards,
Krzysztof


The following changes since commit dfaf06baad0c088a55570f7a324949c498f2106c:

  ARM: dts: exynos: Fix indentation of EHCI and OHCI ports (2017-01-29 21:03:46 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.11-3

for you to fetch changes up to 55d74adfa9758cad5dd989b22cb2558303fe9a0f:

  ARM: dts: exynos: Add labels to all existing power domains (2017-01-31 21:30:48 +0200)

----------------------------------------------------------------
Samsung DeviceTree update for v4.11, third round:
1. Add descriptive user-friendly label names for power domains. This
   makes debugging easier.

----------------------------------------------------------------
Marek Szyprowski (1):
      ARM: dts: exynos: Add labels to all existing power domains

 arch/arm/boot/dts/exynos4.dtsi    | 7 +++++++
 arch/arm/boot/dts/exynos4210.dtsi | 1 +
 arch/arm/boot/dts/exynos4412.dtsi | 1 +
 arch/arm/boot/dts/exynos5250.dtsi | 3 +++
 arch/arm/boot/dts/exynos5420.dtsi | 5 +++++
 5 files changed, 17 insertions(+)
