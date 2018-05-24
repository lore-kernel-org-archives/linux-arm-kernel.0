From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 24 May 2018 20:20:16 +0200
Subject: [GIT PULL 2/2] arm64: dts: exynos: Second round for v4.18
In-Reply-To: <20180524182016.5866-1-krzk@kernel.org>
References: <20180524182016.5866-1-krzk@kernel.org>
Message-ID: <20180524182016.5866-2-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On top of previous pull request.

Best regards,
Krzysztof


The following changes since commit 8dd6203f32f20cb83469eb859efded9e403b3e9f:

  arm64: dts: exynos: Add mem-2-mem Scaler devices (2018-05-13 11:26:13 +0200)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-4.18-2

for you to fetch changes up to f0b5e8a21e6604980c35eeeba1ee3a124f45ad1f:

  arm64: dts: exynos: Add more clocks to Exynos5433 Decon/DeconTV (2018-05-23 20:23:24 +0200)

----------------------------------------------------------------
Samsung DTS ARM64 changes for v4.18, part 2

1. Add clocks necessary for DECON hardware windows no 4 and 5 on
   Exynos5433.

----------------------------------------------------------------
Marek Szyprowski (1):
      arm64: dts: exynos: Add more clocks to Exynos5433 Decon/DeconTV

 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)
