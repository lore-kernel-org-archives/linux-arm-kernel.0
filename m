From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 18 Mar 2018 16:34:15 +0100
Subject: [GIT PULL] ARM: dts: exynos: Second pull for v4.17
Message-ID: <20180318153415.8229-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On top of previous DT pull.

Best regards,
Krzysztof


The following changes since commit 6f4870753f29edf7dc39444246f9e39987b8b158:

  ARM: dts: exynos: Fix IOMMU support for GScaler devices on Exynos5250 (2018-03-05 19:11:40 +0100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.17-2

for you to fetch changes up to 720b5fc3ca0f72b30452089d0510cd1e81a3df6d:

  ARM: dts: exynos: Add #sound-dai-cells property to exynos5250 i2s nodes (2018-03-14 20:14:24 +0100)

----------------------------------------------------------------
Samsung DTS ARM changes for v4.17, part two

1. Fix audio on Exynos5250 Chromebook Snow.
2. Enable HDMI audio Chromebook Snow, Peach Pit and Peach Pi.
3. Fix debounce of "OK" key on Midas (Trats2, Galaxy S3) boards.

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ARM: dts: exynos: Fix "debounce-interval" property misspelling in Midas

Sylwester Nawrocki (7):
      ARM: dts: exynos: Add #sound-dai-cells property to hdmi node in exynos5250.dtsi
      ARM: dts: exynos: Add audio clocks configuration for Snow Chromebook
      ARM: dts: exynos: Add missing clock and DAI properties to the max98095 node in Snow Chromebook
      ARM: dts: exynos: Enable HDMI audio on Snow Chromebook
      ARM: dts: exynos: Enable HDMI audio support on Peach Pit
      ARM: dts: exynos: Enable HDMI audio support on Peach Pi
      ARM: dts: exynos: Add #sound-dai-cells property to exynos5250 i2s nodes

 arch/arm/boot/dts/exynos4412-midas.dtsi       |  2 +-
 arch/arm/boot/dts/exynos5250-snow-common.dtsi | 18 ++++++++++++++++++
 arch/arm/boot/dts/exynos5250-snow.dts         | 11 +++++++++++
 arch/arm/boot/dts/exynos5250.dtsi             |  5 +++++
 arch/arm/boot/dts/exynos5420-peach-pit.dts    | 17 +++++++++++++++++
 arch/arm/boot/dts/exynos5800-peach-pi.dts     | 17 +++++++++++++++++
 6 files changed, 69 insertions(+), 1 deletion(-)
