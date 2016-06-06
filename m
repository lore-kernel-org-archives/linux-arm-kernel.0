From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 06 Jun 2016 14:25:33 +0200
Subject: [GIT PULL 8/8] ARM: defconfig: exynos: Defconfig for v4.8
In-Reply-To: <1465215933-22709-1-git-send-email-k.kozlowski@samsung.com>
References: <1465215933-22709-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1465215933-22709-9-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-defconfig-4.8

for you to fetch changes up to 4b388071a2235ed8f05d05d069f5a5a29782a8c5:

  ARM: exynos_defconfig: Save defconfig on current linux-next (2016-06-06 08:36:55 +0200)

----------------------------------------------------------------
Samsung defconfig update for v4.8:
1. Disable big.LITTLE switcher so the cpufreq-dt could be enabled.
2. Enable Samsung media platform drivers.
3. Enable some board-specific drivers for boards: Trats2, Universal C210.
4. Few more minor additions.

----------------------------------------------------------------
Andrzej Hajda (1):
      ARM: multi_v7_defconfig: Enable Exynos DRM Mixer driver

Bartlomiej Zolnierkiewicz (1):
      ARM: exynos_defconfig: Disable big.LITTLE switcher

Javier Martinez Canillas (4):
      ARM: exynos_defconfig: Enable Samsung media platform drivers as modules
      ARM: multi_v7_defconfig: Enable Samsung media platform drivers as modules
      ARM: exynos_defconfig: Enable MFC driver as module
      ARM: multi_v7_defconfig: Enable Exynos MFC driver as module

Krzysztof Kozlowski (5):
      ARM: multi_v7_defconfig: Switch max77693 to module
      ARM: multi_v7_defconfig: Enable Trats2 audio codec, touchscreen and sensors
      ARM: multi_v7_defconfig: Enable drivers for Exynos4210 Universal C210 board
      ARM: multi_v7_defconfig: Enable s5p-secss driver
      ARM: exynos_defconfig: Save defconfig on current linux-next

 arch/arm/configs/exynos_defconfig   | 27 +++++++++++++++------------
 arch/arm/configs/multi_v7_defconfig | 30 +++++++++++++++++++++++++-----
 2 files changed, 40 insertions(+), 17 deletions(-)
