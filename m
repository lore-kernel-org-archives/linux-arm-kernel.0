From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 02 Dec 2015 10:39:46 +0900
Subject: [GIT PULL 9/9] ARM: EXYNOS: Defconfig for v4.5
In-Reply-To: <1449020386-20250-1-git-send-email-k.kozlowski@samsung.com>
References: <1449020386-20250-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1449020386-20250-10-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

This may conflict with other arm-soc updates...

Best regards,
Krzysztof


The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-defconfig-4.5

for you to fetch changes up to 00a5e81fff2d81c3b1bf45712d3a12c905bc7c66:

  ARM: exynos_defconfig: Set recommended options for systemd (2015-12-01 08:28:44 +0900)

----------------------------------------------------------------
Defconfig (exynos and multi_v7) changes for Exynos based boards for 4.5:
1. Enable Maxim 8997 and 77693 family drivers (charger, extcon, LED,
   RTC, haptic/motor, regulator).
2. Build ChromeOS EC drivers as modules on multi_v7.
3. Enable drivers important for Exynos4210-based Universal C210 board.
4. Enable NFSv4 client.
5. On exynos_defconfig set some options to a value recommended
   by systemd. This also makes it more consistent with multi_v7.

----------------------------------------------------------------
Javier Martinez Canillas (1):
      ARM: multi_v7_defconfig: Build ChromeOS EC drivers as modules

Krzysztof Kozlowski (6):
      ARM: exynos_defconfig: Enable Maxim 8997 family drivers
      ARM: exynos_defconfig: Enable Maxim 77693 LED and haptic drivers
      ARM: multi_v7_defconfig: Enable Maxim 8997 family drivers
      ARM: multi_v7_defconfig: Enable Maxim 77693 LED and haptic drivers
      ARM: exynos_defconfig: Enable NFSv4 client
      ARM: exynos_defconfig: Set recommended options for systemd

Marek Szyprowski (1):
      ARM: exynos_defconfig: Add drivers for Exynos4210 Universal C210 board

 arch/arm/configs/exynos_defconfig   | 18 ++++++++++++++++--
 arch/arm/configs/multi_v7_defconfig | 15 ++++++++++++---
 2 files changed, 28 insertions(+), 5 deletions(-)
