From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 10 Oct 2018 20:25:55 +0200
Subject: [GIT PULL 1/4] ARM: dts: exynos: Second round for v4.20
In-Reply-To: <20181010182558.7034-1-krzk@kernel.org>
References: <20181010182558.7034-1-krzk@kernel.org>
Message-ID: <20181010182558.7034-2-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On top of previous pull request.

Best regards,
Krzysztof


The following changes since commit ff1e37c6809daab75f7b2dea1efe69330e8eb65b:

  ARM: dts: exynos: Correct audio subsystem parent clock on Peach Chromebooks (2018-09-24 18:55:16 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.20-3

for you to fetch changes up to 48ab742ce3b0312f2ee23ed825d3c8820eda7acf:

  ARM: dts: exynos: Add pin configuration for SD write protect on Odroid XU (2018-10-01 18:51:51 +0200)

----------------------------------------------------------------
Samsung DTS ARM changes for v4.20, second round

Add proper configuration for Odroid XU SD write-protect pin.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      ARM: dts: exynos: Add pin configuration for SD write protect on Odroid XU

 arch/arm/boot/dts/exynos5410-odroidxu.dts | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)
