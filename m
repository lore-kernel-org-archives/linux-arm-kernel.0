From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 02 Dec 2015 10:39:41 +0900
Subject: [GIT PULL 4/9] ARM64: EXYNOS: Soc specific code for v4.5
In-Reply-To: <1449020386-20250-1-git-send-email-k.kozlowski@samsung.com>
References: <1449020386-20250-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1449020386-20250-5-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

ARM64 change touch also defconfig.

Best regards,
Krzysztof


The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc64-4.5

for you to fetch changes up to db44c07a3f0b32815bd1f3e731db9e043e57cf9c:

  arm64: EXYNOS: Consolidate ARCH_EXYNOS7 symbol into ARCH_EXYNOS (2015-11-22 19:31:30 +0900)

----------------------------------------------------------------
Samsung Exynos ARM64 improvements:
1. Use just one Kconfig symbol for Exynos SoC: ARCH_EXYNOS.
   This depends on change in drivers/clk where the old ARCH_EXYNOS7
   was used.

----------------------------------------------------------------
Krzysztof Kozlowski (3):
      clk: samsung: Don't build ARMv8 clock drivers on ARMv7
      Merge tag 'samsung-clk-arm64-symbols-4.5' into next/soc64
      arm64: EXYNOS: Consolidate ARCH_EXYNOS7 symbol into ARCH_EXYNOS

 arch/arm64/Kconfig.platforms        | 11 ++---------
 arch/arm64/boot/dts/exynos/Makefile |  2 +-
 arch/arm64/configs/defconfig        |  2 +-
 drivers/clk/samsung/Kconfig         |  6 ++++++
 drivers/clk/samsung/Makefile        |  4 ++--
 5 files changed, 12 insertions(+), 13 deletions(-)
