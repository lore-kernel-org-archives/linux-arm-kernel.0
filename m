From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 14 Apr 2017 22:51:10 +0200
Subject: [PATCH 0/2] ADC support for SPEAr600
Message-ID: <1492203072-27771-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This set of two patches add support for the ADC of the SPEAr600, using
the existing spear_adc driver. Only a Device Tree description and a
minor clock fix are needed to make the ADC work.

Thomas

Thomas Petazzoni (2):
  arm: spear6xx: add DT description of the ADC on SPEAr600
  clk: spear: fix ADC clock definition on SPEAr600

 arch/arm/boot/dts/spear600.dtsi    | 8 ++++++++
 drivers/clk/spear/spear6xx_clock.c | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.7.4
