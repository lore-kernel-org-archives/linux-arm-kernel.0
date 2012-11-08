From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  8 Nov 2012 18:01:50 +0100
Subject: [PATCH 0/3] Add support of the PCA9555 to the CFA-10049
Message-ID: <1352394113-19513-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is an attempt to add support for the PCA9555
present in the CFA-10049 board from Crystalfontz.

The driver was supporting neither irqdomains nor dt, so
the first two patches are adding them.

Thanks,
Maxime

Maxime Ripard (3):
  gpio: pca953x: Register an IRQ domain
  gpio: pca953x: Add compatible strings to gpio-pca953x driver
  ARM: dts: cfa10049: Add PCA9555 GPIO expander to the device tree

 arch/arm/boot/dts/imx28-cfa10049.dts |   26 +++++++++++++++-
 drivers/gpio/gpio-pca953x.c          |   55 ++++++++++++++++++++++++++++++----
 2 files changed, 74 insertions(+), 7 deletions(-)

-- 
1.7.9.5
