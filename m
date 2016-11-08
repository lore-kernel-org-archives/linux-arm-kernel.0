From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue,  8 Nov 2016 20:26:27 +0200
Subject: [GIT PULL 3/3] ARM: defconfig: Samsung defconfigs for v4.10
In-Reply-To: <1478629589-7520-1-git-send-email-krzk@kernel.org>
References: <1478629589-7520-1-git-send-email-krzk@kernel.org>
Message-ID: <1478629589-7520-2-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Nothing special.

Best regards,
Krzysztof


The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-defconfig-4.10

for you to fetch changes up to e471e9b4b13b59ee8cb7079018472c4dda46cb7a:

  ARM: multi_v7_defconfig: Enable exynos-gsc driver as module (2016-10-17 19:43:29 +0300)

----------------------------------------------------------------
Samsung defconfig update for v4.10:
1. Enable the Exynos gscaler driver on multi_v7 and exynos defconfigs.

----------------------------------------------------------------
Javier Martinez Canillas (2):
      ARM: exynos_defconfig: Enable exynos-gsc driver as module
      ARM: multi_v7_defconfig: Enable exynos-gsc driver as module

 arch/arm/configs/exynos_defconfig   | 1 +
 arch/arm/configs/multi_v7_defconfig | 1 +
 2 files changed, 2 insertions(+)
