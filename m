From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue,  1 Mar 2016 18:37:21 +0900
Subject: [GIT PULL] ARM64: EXYNOS: defconfig for 4.6
In-Reply-To: <1456825042-23733-1-git-send-email-k.kozlowski@samsung.com>
References: <1456825042-23733-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1456825042-23733-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Defconfig changes for v4.6, for ARM64 (second pull request for defconfig).
This is on top of previous defconfig changes.

This may conflict with other changes to arch/arm64/configs/defconfig.
Just add everything.

Best regards,
Krzysztof


The following changes since commit 5d51f1dde207f2d5d43158da75c6608f7bfcec03:

  ARM: multi_v7_defconfig: Remove MAX77802 RTC Kconfig symbol (2016-02-05 09:11:32 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-defconfig-4.6-2

for you to fetch changes up to 6bb8371893889ba877652107ae59eecb8d86edc4:

  arm64: defconfig: Enable Samsung MFD and related configs (2016-03-01 17:55:03 +0900)

----------------------------------------------------------------
ARM64 defconfig changes for Exynos based boards for v4.6:
1. We want thermal for Exynos7 TMU unit to monitor the temperature.
2. Enable the drivers for PMIC used on Exynos7-based Espresso board.

----------------------------------------------------------------
Alim Akhtar (2):
      arm64: defconfig: Enable exynos thermal config
      arm64: defconfig: Enable Samsung MFD and related configs

 arch/arm64/configs/defconfig | 6 ++++++
 1 file changed, 6 insertions(+)
