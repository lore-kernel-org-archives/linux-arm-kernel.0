From: davidb@codeaurora.org (David Brown)
Date: Thu, 18 Jul 2013 13:07:12 -0700
Subject: [PATCH 0/3] MSM gpio fixes
Message-ID: <1374178035-19943-1-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rohit sent these three fixes out on June 18.  I still need a
devicetree ack for the first patch, and would like these to get pulled
in for v3.11

Rohit Vaswani (3):
  ARM: msm: dts: Fix the gpio register address for msm8960
  drivers: gpio: msm: Fix the error condition for reading ngpio
  ARM: msm: Consolidate gpiomux for older architectures

 arch/arm/boot/dts/msm8960-cdp.dts |  4 ++--
 arch/arm/mach-msm/Kconfig         |  3 +--
 arch/arm/mach-msm/gpiomux-v1.c    | 33 ---------------------------------
 arch/arm/mach-msm/gpiomux.h       | 10 ----------
 drivers/gpio/gpio-msm-v2.c        |  2 +-
 5 files changed, 4 insertions(+), 48 deletions(-)
 delete mode 100644 arch/arm/mach-msm/gpiomux-v1.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
