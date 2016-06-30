From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 30 Jun 2016 09:51:15 +0200
Subject: [GIT PULL 4/4] ARM: defconfig: exynos: Stuff for v4.8, part 2
In-Reply-To: <1467273075-13747-1-git-send-email-k.kozlowski@samsung.com>
References: <1467273075-13747-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1467273075-13747-5-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On top of previous pull.

Best regards,
Krzysztof


The following changes since commit 4b388071a2235ed8f05d05d069f5a5a29782a8c5:

  ARM: exynos_defconfig: Save defconfig on current linux-next (2016-06-06 08:36:55 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-defconfig-4.8-2

for you to fetch changes up to 065069248736926d2a89ff99372270fbf38537f6:

  ARM: multi_v7_defconfig: Enable vivid driver as a module (2016-06-27 08:19:09 +0200)

----------------------------------------------------------------
Samsung defconfig update for v4.8, part 2:
1. Enable Virtual Video Test Driver on nulti_v7 and exynos defconfigs.
   Useful for testing.

----------------------------------------------------------------
Javier Martinez Canillas (2):
      ARM: exynos_defconfig: Enable vivid driver as a module
      ARM: multi_v7_defconfig: Enable vivid driver as a module

 arch/arm/configs/exynos_defconfig   | 2 ++
 arch/arm/configs/multi_v7_defconfig | 2 ++
 2 files changed, 4 insertions(+)
