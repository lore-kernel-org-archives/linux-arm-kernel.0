From: josh.wu@atmel.com (Josh Wu)
Date: Thu, 12 Feb 2015 16:06:22 +0800
Subject: [PATCH 0/4] ARM: at91: at91sam9x5: enable ISI and ov2640 support
Message-ID: <1423728386-24544-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series will enable ISI and ov2640 sensor support for
at91sam9g25ek board.


Josh Wu (4):
  ARM: at91: at91sam9x5/dts: add ISI dt support, include isi node,
    pinctrls
  ARM: at91: at91sam9x5ek/dts: add ov2640 support
  ARM: at91: at91sam9g25ek/dts: enable ISI and ov2640
  ARM: at91: at91_dt_defconfig: enable ISI and ov2640 support

 arch/arm/boot/dts/at91sam9g25.dtsi    |  1 +
 arch/arm/boot/dts/at91sam9g25ek.dts   | 18 +++++++++++++
 arch/arm/boot/dts/at91sam9x5_isi.dtsi | 46 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9x5ek.dtsi   | 48 +++++++++++++++++++++++++++++++++++
 arch/arm/configs/at91_dt_defconfig    |  6 +++++
 5 files changed, 119 insertions(+)

-- 
1.9.1
