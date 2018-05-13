From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 13 May 2018 17:42:34 +0200
Subject: [GIT PULL 1/5] ARM: defconfig: Exynos for v4.18
In-Reply-To: <20180513154238.22508-1-krzk@kernel.org>
References: <20180513154238.22508-1-krzk@kernel.org>
Message-ID: <20180513154238.22508-2-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-defconfig-4.18

for you to fetch changes up to b0121046cacdbc99475871aceb2e9e57995c2ba1:

  ARM: multi_v7_config: enable S6E63J0X03 panel driver (2018-04-16 20:22:28 +0200)

----------------------------------------------------------------
Samsung defconfig changes for v4.18

1. Enable Samsung S6E63J0X03 DSI panel.

----------------------------------------------------------------
Marek Szyprowski (2):
      ARM: exynos_defconfig: enable S6E63J0X03 panel driver
      ARM: multi_v7_config: enable S6E63J0X03 panel driver

 arch/arm/configs/exynos_defconfig   | 1 +
 arch/arm/configs/multi_v7_defconfig | 1 +
 2 files changed, 2 insertions(+)
