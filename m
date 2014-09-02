From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue,  2 Sep 2014 10:49:56 +0200
Subject: [PATCH 0/7] ARM: at91: update defconfigs
Message-ID: <1409647803-8054-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following recent work on the AT91 platforms, update the defconfigs to include
the new power and reset driver, the ADC and touchscreen driver, the new PWM
driver using the generic PWM framework.

Also remove deprecated options like CONFIG_PROC_DEVICETREE,
CONFIG_SCSI_MULTI_LUN, CONFIG_MII, CONFIG_MTD_CHAR.

Alexandre Belloni (7):
  ARM: at91: at91_dt: update defconfig
  ARM: at91: at91sam9260_9g20: update defconfig
  ARM: at91: at91sam9261_9g10: update defconfig
  ARM: at91: at91sam9263: update defconfig
  ARM: at91: at91sam9g45: update defconfig
  ARM: at91: at91sam9rl: update defconfig
  ARM: at91: sama5: update defconfig

 arch/arm/configs/at91_dt_defconfig          | 25 +++++++++++++------------
 arch/arm/configs/at91sam9260_9g20_defconfig | 13 +++++--------
 arch/arm/configs/at91sam9261_9g10_defconfig |  5 ++---
 arch/arm/configs/at91sam9263_defconfig      | 13 ++++++-------
 arch/arm/configs/at91sam9g45_defconfig      | 19 +++++++++++--------
 arch/arm/configs/at91sam9rl_defconfig       | 19 ++++++++++++++-----
 arch/arm/configs/sama5_defconfig            | 12 ++++++------
 7 files changed, 57 insertions(+), 49 deletions(-)

-- 
1.9.1
