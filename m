From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat,  8 Apr 2017 16:10:00 +0200
Subject: [GIT PULL 5/5] ARM: defconfig: exynos for v4.12
In-Reply-To: <20170408141004.386-1-krzk@kernel.org>
References: <20170408141004.386-1-krzk@kernel.org>
Message-ID: <20170408141004.386-2-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-defconfig-4.12

for you to fetch changes up to fd2694a112d6b53eba8d8e182fef0dccdab6c9e8:

  ARM: exynos_defconfig: Increase CONFIG_CMA_SIZE_MBYTES to 96 (2017-03-07 21:01:52 +0200)

----------------------------------------------------------------
Samsung defconfig ARM update for v4.12:
1. Enable DYNAMIC_DEBUG because it is useful for debugging.
2. Increase CMA memory region to allow handling H.264 1080p videos.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      ARM: exynos_defconfig: Enable DYNAMIC_DEBUG and get rid of old ext3

Shuah Khan (1):
      ARM: exynos_defconfig: Increase CONFIG_CMA_SIZE_MBYTES to 96

 arch/arm/configs/exynos_defconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
