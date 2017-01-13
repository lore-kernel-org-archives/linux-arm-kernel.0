From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 13 Jan 2017 17:20:30 +0200
Subject: [GIT PULL 4/4] ARM: defconfig: exynos: Defconfig for v4.11
In-Reply-To: <20170113152030.13586-1-krzk@kernel.org>
References: <20170113152030.13586-1-krzk@kernel.org>
Message-ID: <20170113152030.13586-4-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-defconfig-4.11

for you to fetch changes up to 74b0ee7579f279dae053053008d29f10f3890c07:

  ARM: exynos_defconfig: Enable IP multicast (2016-12-29 16:04:57 +0200)

----------------------------------------------------------------
Samsung defconfig update for v4.11:
1. Cleanup from old MACHs in s5pv210.
2. Enable IP_MULTICAST for libnss-mdns.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      ARM: s5pv210_defconfig: Remove old MACHs

Robie Basak (1):
      ARM: exynos_defconfig: Enable IP multicast

 arch/arm/configs/exynos_defconfig  | 1 +
 arch/arm/configs/s5pv210_defconfig | 4 ----
 2 files changed, 1 insertion(+), 4 deletions(-)
