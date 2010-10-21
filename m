From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Thu, 21 Oct 2010 19:14:16 +0200
Subject: [PATCH 0/4] ARM: S3C64XX: SmartQ suspend support
Message-ID: <cover.1287681256.git.mcuelenaere@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add suspend support to SmartQ boards, plus some S3C PM related
cleanups.

Maurus Cuelenaere (4):
  ARM: SAMSUNG: make SAMSUNG_PM_DEBUG select DEBUG_LL
  ARM: SAMSUNG: Fix warning 's3c_pm_show_resume_irqs' defined but not
    used
  ARM: S3C64XX: Add suspend support to SmartQ boards
  ARM: S3C64XX: Add wakeup sources to SmartQ boards

 arch/arm/mach-s3c64xx/mach-smartq.c  |    4 ++++
 arch/arm/mach-s3c64xx/mach-smartq5.c |    1 +
 arch/arm/mach-s3c64xx/mach-smartq7.c |    1 +
 arch/arm/plat-samsung/Kconfig        |    1 +
 arch/arm/plat-samsung/pm.c           |    5 +++--
 5 files changed, 10 insertions(+), 2 deletions(-)

-- 
1.7.2.3
