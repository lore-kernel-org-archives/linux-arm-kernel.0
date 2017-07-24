From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 24 Jul 2017 21:08:55 +0200
Subject: [GIT PULL 4/5] ARM: defconfig: Exynos updates for v4.14
In-Reply-To: <20170724190856.19055-1-krzk@kernel.org>
References: <20170724190856.19055-1-krzk@kernel.org>
Message-ID: <20170724190856.19055-4-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-defconfig-4.14

for you to fetch changes up to 57ee24144e57b762dc46f171e1f138ccfc464867:

  ARM: exynos_defconfig: Enable locking test options (2017-07-18 17:58:46 +0200)

----------------------------------------------------------------
Samsung defconfig changes for v4.14

1. Enable some drivers useful on our boards (communication: Bluetooth,
   WiFi, NFC, USB; codepages and crypto algorithms).
2. Enable debugging and lock testing options. These might have impact on
   performance but we use the exynos_defconfig a lot during development
   so they should bring benefits of detecting early locking issues.

----------------------------------------------------------------
Krzysztof Kozlowski (3):
      ARM: exynos_defconfig: Enable Bluetooth, mac80211, NFC and more USB drivers
      ARM: exynos_defconfig: Enable NLS_UTF8 and some crypto algorithms
      ARM: exynos_defconfig: Enable locking test options

 arch/arm/configs/exynos_defconfig | 79 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 73 insertions(+), 6 deletions(-)
