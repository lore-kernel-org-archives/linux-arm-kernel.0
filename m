From: josh.wu@atmel.com (Josh Wu)
Date: Wed, 19 Dec 2012 18:27:17 +0800
Subject: [PATCH 0/3] at91: PMECC: enable PMECC in dt for at91sam9x5ek,
 at91sam9n12ek
Message-ID: <1355912840-29501-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Those patches will enable PMECC in dt parameters for at91sam9x5ek, at91sam9n12ek.

Josh Wu (3):
  MTD: at91: atmel_nand: for PMECC, add code to choose the ecc bits and
    sector size according to the ONFI parameter ECC requirement.
  at91: 9x5: add DT parameters to enable PMECC
  at91: at91sam9n12: add DT parameters to enable PMECC

 arch/arm/boot/dts/at91sam9n12.dtsi  |    1 +
 arch/arm/boot/dts/at91sam9n12ek.dts |    5 +-
 arch/arm/boot/dts/at91sam9x5.dtsi   |    4 ++
 arch/arm/boot/dts/at91sam9x5cm.dtsi |    5 +-
 drivers/mtd/nand/atmel_nand.c       |   89 +++++++++++++++++++++++++++++++++++
 5 files changed, 102 insertions(+), 2 deletions(-)

-- 
1.7.9.5
