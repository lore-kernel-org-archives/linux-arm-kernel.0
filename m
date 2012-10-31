From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 31 Oct 2012 11:30:07 +0100
Subject: [PATCHv2 0/3] Add spidev to the CFA-10049
Message-ID: <1351679410-11026-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This patchset probes spidev on the SSP3 bus where on the CFA-10049 there is
a Rohm DH2228FV DAC.

It first adds the dt bindings for the spidev driver, and the proper node in
the CFA-10049 device tree file.

Maxime

Changes from v1:
  - Removed the linux,spidev compatible string and use the compatible strings
    of the devices instead.

Maxime Ripard (3):
  spi: spidev: Add device tree bindings
  spi: spidev: Add Rohm DH2228FV DAC compatible string
  ARM: dts: cfa10049: Add the DH2228FV DAC to the DTS

 arch/arm/boot/dts/imx28-cfa10049.dts |    6 ++++++
 drivers/spi/spidev.c                 |   10 ++++++++++
 2 files changed, 16 insertions(+)

-- 
1.7.9.5
