From: clg@kaod.org (=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=)
Date: Wed,  1 Mar 2017 15:26:41 +0100
Subject: [PATCH 0/2] aspeed: add bindings and defconfig for SPI controllers
Message-ID: <1488378403-24640-1-git-send-email-clg@kaod.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here's a short series to activate by the default the SPI controllers
on the Aspeed SoC AST2400 and AST2500.

Thanks,

C. 

C?dric Le Goater (2):
  ARM: dts: aspeed: add SPI controller bindings
  ARM: aspeed: Add CONFIG_SPI_ASPEED_SMC

 arch/arm/boot/dts/aspeed-ast2500-evb.dts      | 20 +++++++++
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts | 16 +++++++
 arch/arm/boot/dts/aspeed-g4.dtsi              | 29 ++++++++++++
 arch/arm/boot/dts/aspeed-g5.dtsi              | 63 +++++++++++++++++++++++++++
 arch/arm/configs/aspeed_g4_defconfig          |  3 ++
 arch/arm/configs/aspeed_g5_defconfig          |  3 ++
 6 files changed, 134 insertions(+)

-- 
2.7.4
