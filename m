From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Mon, 16 Oct 2017 17:46:18 +0530
Subject: [PATCH 0/9] rockchip: rk3288-vyasa: dts fixes/additions
Message-ID: <1508156187-27519-1-git-send-email-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Series add new dts nodes like gmac, usb, io_domains and fixed existing
regulator, pmic stuff as per schematic. 

Jagan Teki (9):
  ARM: dts: rockchip: rk3288-vyasa: Remove vdd_log from rk808, DCDC_REG1
  ARM: dts: rockchip: rk3288-vyasa: Use fixed voltage range for vccio_sd
  ARM: dts: rockchip: rk3288-vyasa: Use vmmc-supply from PMIC
  ARM: dts: rockchip: Add regulators for rk3288-vyasa
  ARM: dts: rockchip: Add gmac support for rk3288-vyasa board
  ARM: dts: rockchip: Add usb host for rk3288-vyasa
  ARM: dts: rockchip: Add usb otg for rk3288-vyasa
  ARM: dts: rockchip: Add io domains for rk3288-vyasa
  ARM: multi_v7_defconfig: Statically build RTC_DRV_RK808

 arch/arm/boot/dts/rk3288-vyasa.dts     | 181 ++++++++++++++++++++++++++++++---
 arch/arm/configs/multi_v7_defconfig    |   2 +-
 include/dt-bindings/pinctrl/rockchip.h |   1 +
 3 files changed, 168 insertions(+), 16 deletions(-)

-- 
2.7.4
