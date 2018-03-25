From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 25 Mar 2018 14:10:49 +0200
Subject: [GIT PULL] ARM: exynos: mach for v4.17, part two
Message-ID: <20180325121049.15357-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Second pull request for mach code. On top of previous pull request.


Best regards,
Krzysztof


The following changes since commit cc14b2b1f0b98926b6640bdd66861188ded850eb:

  ARM: EXYNOS: Extend cpuidle support to Midas boards (2018-02-19 17:55:49 +0100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-4.17-2

for you to fetch changes up to ae35c4835699933335e76ab2d6a245303592ceea:

  ARM: EXYNOS: Simplify code in coupled CPU idle hot path (2018-03-21 18:51:39 +0100)

----------------------------------------------------------------
Samsung mach/soc changes for v4.17, part two

1. Fix coupled CPU idle freeze on Exynos4210.
2. Simplify hot-path in coupled CPU idle.

----------------------------------------------------------------
Marek Szyprowski (2):
      ARM: EXYNOS: Fix coupled CPU idle freeze on Exynos4210
      ARM: EXYNOS: Simplify code in coupled CPU idle hot path

 arch/arm/mach-exynos/pm.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)
