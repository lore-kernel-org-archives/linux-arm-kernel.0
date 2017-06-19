From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 19 Jun 2017 18:05:08 +0200
Subject: [GIT PULL 1/2] ARM: dts: exynos: Second round for v4.13
Message-ID: <20170619160509.5065-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On top of previous pull request, just minor stuff.

Best regards,
Krzysztof


The following changes since commit c92a4fb249bf98670543b4c41307e1e71942d513:

  ARM: dts: exynos: Use human-friendly symbols for GIC interrupt properties (2017-06-07 20:56:06 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.13-2

for you to fetch changes up to bc8ebb86392dc2e81abee68c4e569f8d23628603:

  ARM: dts: exynos: Fix polarity of panel reset gpio in Rinato (2017-06-16 18:17:23 +0200)

----------------------------------------------------------------
Samsung DeviceTree update for v4.13, part two:
1. Add needed property for CEC on Odroid U3,
2. Fix reset GPIO polarity on Rinato.

----------------------------------------------------------------
Hans Verkuil (1):
      ARM: dts: exynos: add needs-hpd to &hdmicec for Odroid-U3

Hoegeun Kwon (1):
      ARM: dts: exynos: Fix polarity of panel reset gpio in Rinato

 arch/arm/boot/dts/exynos3250-rinato.dts   | 2 +-
 arch/arm/boot/dts/exynos4412-odroidu3.dts | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)
