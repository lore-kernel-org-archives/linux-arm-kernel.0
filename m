From: gbean@codeaurora.org (Gregory Bean)
Date: Wed, 23 Jun 2010 14:30:33 -0700
Subject: [PATCH 0/3 v3] msm: Add gpiolib devices to MSM7x30 and QSD8x50.
Message-ID: <1277328636-27421-1-git-send-email-gbean@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi folks:

Here is a proposed patch series which adds the configuration and devices
needed to enable gpiolib on the MSM7x30 and QSD8x50 chipsets.

Thanks,

G

Gregory Bean (3):
  msm: Add gpio register address mapping information.
  msm: 7x30: Add gpio device configuration.
  msm: 8x50: add gpio device configuration.

 arch/arm/mach-msm/board-msm7x30.c     |   27 ++++++++-
 arch/arm/mach-msm/board-qsd8x50.c     |   27 ++++++++-
 arch/arm/mach-msm/devices-msm7x30.c   |   21 +++++++
 arch/arm/mach-msm/devices-qsd8x50.c   |   21 +++++++
 arch/arm/mach-msm/devices.h           |   33 +++++++++++
 arch/arm/mach-msm/gpio_hw-7x30.h      |  100 +++++++++++++++++++++++++++++++++
 arch/arm/mach-msm/gpio_hw-7xxx.h      |   84 +++++++++++++++++++++++++++
 arch/arm/mach-msm/gpio_hw-8x50.h      |  100 +++++++++++++++++++++++++++++++++
 arch/arm/mach-msm/gpio_hw.h           |   35 +++++++++++
 arch/arm/mach-msm/include/mach/gpio.h |    2 +
 10 files changed, 446 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-msm/gpio_hw-7x30.h
 create mode 100644 arch/arm/mach-msm/gpio_hw-7xxx.h
 create mode 100644 arch/arm/mach-msm/gpio_hw-8x50.h
 create mode 100644 arch/arm/mach-msm/gpio_hw.h

--
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
