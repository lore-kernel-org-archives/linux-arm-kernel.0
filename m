From: kgene@kernel.org (Kukjin Kim)
Date: Sat, 24 Oct 2015 06:23:32 +0900
Subject: [GIT PULL 3/5] Late Samsung SoC updates for v4.4
In-Reply-To: <562AA40E.4050407@kernel.org>
References: <562AA40E.4050407@kernel.org>
Message-ID: <562AA554.3040604@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-soc

for you to fetch changes up to 97d5c7a77e39ab96a2a6137de0e35dd6e3f38325:

  Documentation: EXYNOS: Update bootloader interface on exynos542x
(2015-10-24 04:43:31 +0900)

----------------------------------------------------------------
Samsung SoC updates for v4.4

- use PWM lookup table with pwm_add_table() for the following boards
  : s3c24xx h1940 and rx1950
  : s3c64xx smdk6410, crag6410, hmt and smartq
- document: update bootloader interface on exynos542x

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      Documentation: EXYNOS: Update bootloader interface on exynos542x

Thierry Reding (6):
      ARM: S3C24XX: Use PWM lookup table for mach-h1940
      ARM: S3C24XX: Use PWM lookup table for mach-rx1950
      ARM: S3C64XX: Use PWM lookup table for smdk6410
      ARM: S3C64XX: Use PWM lookup table for mach-crag6410
      ARM: S3C64XX: Use PWM lookup table for mach-hmt
      ARM: S3C64XX: Use PWM lookup table for mach-smartq

 Documentation/arm/Samsung/Bootloader-interface.txt |  5 +++--
 arch/arm/mach-s3c24xx/mach-h1940.c                 | 10 +++++++---
 arch/arm/mach-s3c24xx/mach-rx1950.c                |  8 ++++++--
 arch/arm/mach-s3c64xx/dev-backlight.c              |  4 ----
 arch/arm/mach-s3c64xx/mach-crag6410.c              |  9 +++++++--
 arch/arm/mach-s3c64xx/mach-hmt.c                   |  9 +++++++--
 arch/arm/mach-s3c64xx/mach-smartq.c                |  9 +++++++--
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |  8 +++++++-
 8 files changed, 44 insertions(+), 18 deletions(-)
