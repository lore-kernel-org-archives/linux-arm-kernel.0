From: csd@broadcom.com (Christian Daudt)
Date: Thu, 20 Jun 2013 15:34:35 -0700
Subject: [GIT PULL] ARM: bcm281xx DT  for 3.11
Message-ID: <51C3837B.6050500@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,
  Please pull the branch below. It contains dt portion of sdhci driver + 
misc dt cleanups.

  Thanks,
    csd


The following changes since commit 317ddd256b9c24b0d78fa8018f80f1e495481a10:

   Linux 3.10-rc5 (2013-06-08 17:41:04 -0700)

are available in the git repository at:

   git://github.com/broadcom/bcm11351.git armsoc/for-3.11/dt

for you to fetch changes up to d22dc5ed2a6adc1692b11a64cd3235381e230425:

   ARM: dts: bcm281xx: change comment to C89 style (2013-06-20 14:13:22 
-0700)

----------------------------------------------------------------
DT related patches for 3.11

----------------------------------------------------------------
Christian Daudt (1):
       ARM: mmc: bcm281xx SDHCI driver (dt mods)

Matt Porter (3):
       ARM: dts: bcm281xx: use #include for device tree files
       ARM: dts: bcm281xx: use existing defines for irqs
       ARM: dts: bcm281xx: change comment to C89 style

  Documentation/devicetree/bindings/mmc/bcm,kona-sdhci.txt |   16 
++++++++++++++++
  arch/arm/boot/dts/bcm11351-brt.dts                       |   19 
++++++++++++++++++-
  arch/arm/boot/dts/bcm11351.dtsi                          |   39 
+++++++++++++++++++++++++++++++++++----
  3 files changed, 69 insertions(+), 5 deletions(-)
  create mode 100644 
Documentation/devicetree/bindings/mmc/bcm,kona-sdhci.txt
