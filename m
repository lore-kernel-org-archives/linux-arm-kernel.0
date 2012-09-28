From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 28 Sep 2012 14:50:14 +0200
Subject: [PATCH 0/2] Add spidev to the CFA-10049
Message-ID: <1348836616-29783-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This patchset probes spidev on the SSP3 bus where on the CFA-10049 there is
a DAC.

It first adds the dt bindings for the spidev driver, and the proper node in
the CFA-10049 device tree file.

Maxime

Maxime Ripard (2):
  spi: spidev: Add device tree bindings
  ARM: dts: cfa10049: Add spidev to drive the DAC on SSP3

 arch/arm/boot/dts/imx28-cfa10049.dts |    6 ++++++
 drivers/spi/spidev.c                 |   10 ++++++++++
 2 files changed, 16 insertions(+)

-- 
1.7.9.5
