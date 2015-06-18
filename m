From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 18 Jun 2015 14:38:38 +0200
Subject: [PATCH 0/3] ARM: mvebu: minor improvements to Armada 388 GP support
Message-ID: <1434631121-32014-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This small set of three commits makes some minor improvements to the
Armada 388 GP board support.

Thomas

Thomas Petazzoni (3):
  ARM: mvebu: fix description of pwr-sata0 regulator on Armada 388 GP
  ARM: mvebu: update EEPROM description of Armada 388 GP
  ARM: mvebu: update mvebu_v7_defconfig with features needed for Armada
    388 GP

 arch/arm/boot/dts/armada-388-gp.dts | 12 +++++++-----
 arch/arm/configs/mvebu_v7_defconfig |  4 ++++
 2 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.1.0
