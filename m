From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 06 Jun 2016 14:25:26 +0200
Subject: [GIT PULL 1/8] ARM: exynos: Mach/soc changes for v4.8
In-Reply-To: <1465215933-22709-1-git-send-email-k.kozlowski@samsung.com>
References: <1465215933-22709-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1465215933-22709-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-4.8

for you to fetch changes up to da81593a5a0d93fcca45baa15d0628ba8405695b:

  ARM: s3c24xx: Sort cpufreq tables (2016-06-03 13:54:36 +0200)

----------------------------------------------------------------
Samsung mach/soc update for v4.8:
1. Minor cleanups.

----------------------------------------------------------------
Andrea Gelmini (1):
      ARM: SAMSUNG: Fix typos

Viresh Kumar (1):
      ARM: s3c24xx: Sort cpufreq tables

 arch/arm/mach-s3c24xx/include/mach/regs-gpio.h     | 2 +-
 arch/arm/mach-s3c24xx/iotiming-s3c2410.c           | 2 +-
 arch/arm/mach-s3c24xx/mach-n30.c                   | 2 +-
 arch/arm/mach-s3c24xx/mach-osiris-dvs.c            | 2 +-
 arch/arm/mach-s3c24xx/pll-s3c2410.c                | 3 ++-
 arch/arm/mach-s3c24xx/pll-s3c2440-12000000.c       | 1 +
 arch/arm/mach-s3c24xx/pll-s3c2440-16934400.c       | 1 +
 arch/arm/mach-s3c64xx/include/mach/map.h           | 2 +-
 arch/arm/plat-samsung/include/plat/cpu-freq-core.h | 2 +-
 arch/arm/plat-samsung/include/plat/fb-s3c2410.h    | 2 +-
 arch/arm/plat-samsung/include/plat/gpio-cfg.h      | 2 +-
 arch/arm/plat-samsung/pm-check.c                   | 2 +-
 arch/arm/plat-samsung/watchdog-reset.c             | 2 +-
 13 files changed, 14 insertions(+), 11 deletions(-)
