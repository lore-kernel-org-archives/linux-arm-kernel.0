From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri,  9 Jun 2017 18:42:48 +0200
Subject: [GIT PULL 3/4] arm64: dts: exynos: DT for v4.13
In-Reply-To: <20170609164249.1656-1-krzk@kernel.org>
References: <20170609164249.1656-1-krzk@kernel.org>
Message-ID: <20170609164249.1656-4-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-4.13

for you to fetch changes up to 2f7337c3f3fa1ef6c4c862a96b1349f571df34c8:

  arm64: dts: exynos: Remove the te-gpios property in the TM2 boards (2017-05-15 18:55:25 +0200)

----------------------------------------------------------------
Samsung DeviceTree ARM64 update for v4.13:
1. Remove unneeded TE interrupt gpio property.

----------------------------------------------------------------
Hoegeun Kwon (1):
      arm64: dts: exynos: Remove the te-gpios property in the TM2 boards

 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts | 1 -
 1 file changed, 1 deletion(-)
