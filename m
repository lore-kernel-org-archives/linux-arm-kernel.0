From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 15 Mar 2010 23:20:27 +0000
Subject: [PULL] Please pull bjdooks' for-linus/samsung-fixes
Message-ID: <20100315232027.GA11570@fluff.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please pull the following ARM/Samsung fixes:

The following changes since commit a3d3203e4bb40f253b1541e310dc0f9305be7c84:
  Linus Torvalds (1):
        Merge branch 'release' of git://git.kernel.org/.../lenb/linux-acpi-2.6

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git for-linus/samsung-fixes

Ben Dooks (2):
      ARM: SAMSUNG: Fix build error from stale define in <plat/uncompress.h>
      ARM: SAMSUNG: Fixup commit 4e6d488af37980d224cbf298224db6173673f362

Vasily Khoruzhick (2):
      ARM: S3C2440: Fix s3c2440 cpufreq compilation post move.
      ARM: SAMSUNG: Add suspend/resume support for S3C PWM driver

 .../s3c2440-cpufreq.c                              |    0
 arch/arm/mach-s3c64xx/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-s5p6440/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-s5p6442/include/mach/debug-macro.S   |    2 +-
 arch/arm/plat-samsung/include/plat/uncompress.h    |    2 -
 arch/arm/plat-samsung/pwm.c                        |   35 ++++++++++++++++++++
 6 files changed, 38 insertions(+), 5 deletions(-)
 rename arch/arm/{plat-s3c24xx => mach-s3c2440}/s3c2440-cpufreq.c (100%)

-- 
Ben (ben at fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
