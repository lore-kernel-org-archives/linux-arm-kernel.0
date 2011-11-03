From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 3 Nov 2011 19:00:44 +0200
Subject: [PATCH 0/3] Change ARCH_NR_GPIO into a Kconfig variable
Message-ID: <1320339647-30255-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset converts ARCH_NR_GPIO to a Kconfig variable as suggested by
Russel King. It also converts some platforms to the new model.

Peter De Schrijver (3):
  ARM: ARCH_NR_GPIO: Make ARCH_NR_GPIO a Kconfig variable
  ARM: mach-shmobile: Use CONFIG_ARCH_NR_GPIO
  ARM: mach-ux500 Use CONFIG_ARCH_NR_GPIO

 arch/arm/Kconfig                           |   10 ++++++++++
 arch/arm/include/asm/gpio.h                |    4 ++++
 arch/arm/mach-shmobile/include/mach/gpio.h |    2 --
 arch/arm/mach-ux500/include/mach/gpio.h    |    5 -----
 4 files changed, 14 insertions(+), 7 deletions(-)

-- 
1.7.7.rc0.72.g4b5ea.dirty
