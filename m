From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 30 May 2011 12:51:02 +0530
Subject: [PATCH 0/3] SPEAr320: Add pwm support
Message-ID: <cover.1306739836.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds driver for ST Microelectronics PWM and machine support for
SPEAr320 Machines.

It was earlier reviewed as part of following patchset:
"[PATCH V6 00/17] Adding devices support for all spear machines"

Changes since earlier patchset:
 - Moved driver to drivers/misc/ directory.

Viresh Kumar (3):
  misc/st_pwm: Add support for ST's Pulse Width Modulator
  SPEAr3xx: Add machine support for ST's PWM IP
  SPEAr3xx: Update defconfig for ST's PWM

 MAINTAINERS                                   |    5 +
 arch/arm/configs/spear3xx_defconfig           |    2 +
 arch/arm/mach-spear3xx/include/mach/generic.h |    1 +
 arch/arm/mach-spear3xx/spear320.c             |   16 +
 arch/arm/mach-spear3xx/spear320_evb.c         |    1 +
 drivers/misc/Kconfig                          |    7 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/st_pwm.c                         |  486 +++++++++++++++++++++++++
 8 files changed, 519 insertions(+), 0 deletions(-)
 create mode 100644 drivers/misc/st_pwm.c

-- 
1.7.2.2
