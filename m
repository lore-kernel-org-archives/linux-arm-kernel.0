From: csd@broadcom.com (Christian Daudt)
Date: Tue, 20 Aug 2013 11:33:59 -0700
Subject: [GIT PULL] ARM: bcm DT  for 3.12
Message-ID: <5213B697.2080207@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,
  Please pull the branch below. It contains various DT related cleanups 
for BCM arch.

  Thanks,
    csd


The following changes since commit c095ba7224d8edc71dcef0d655911399a8bd4a3f:

   Linux 3.11-rc4 (2013-08-04 13:46:46 -0700)

are available in the git repository at:

   git://github.com/broadcom/bcm11351.git armsoc/for-3.12/dt

for you to fetch changes up to 15e22ddf045ed9796d0d2302e759aa7a37826523:

   ARM: DT: binding fixup to align with vendor-prefixes.txt (DT) 
(2013-08-20 10:47:47 -0700)

----------------------------------------------------------------
DT related BCM mods for 3.12

----------------------------------------------------------------
Christian Daudt (3):
       ARM: dts: align sdio numbers to HW definition
       ARM: dts: add sdio blocks to bcm28155-ap board
       ARM: DT: binding fixup to align with vendor-prefixes.txt (DT)

Markus Mayer (2):
       ARM: bcm281xx: DT changes for reboot code

  Documentation/devicetree/bindings/arm/bcm/bcm11351.txt |    3 ++-
  Documentation/devicetree/bindings/arm/bcm/{bcm,kona-timer.txt => 
kona-timer.txt} |    5 +++--
  Documentation/devicetree/bindings/arm/bcm/kona-wdt.txt |   15 
+++++++++++++++
  Documentation/devicetree/bindings/misc/smc.txt |    5 +++--
  Documentation/devicetree/bindings/mmc/{bcm,kona-sdhci.txt => 
kona-sdhci.txt}     |    5 +++--
  arch/arm/boot/dts/Makefile |    3 ++-
  arch/arm/boot/dts/bcm11351-brt.dts |    8 ++++----
  arch/arm/boot/dts/bcm11351.dtsi |   33 +++++++++++++++++++--------------
  arch/arm/boot/dts/bcm28155-ap.dts |   45 
+++++++++++++++++++++++++++++++++++++++++++++
  9 files changed, 96 insertions(+), 26 deletions(-)
  rename Documentation/devicetree/bindings/arm/bcm/{bcm,kona-timer.txt 
=> kona-timer.txt} (80%)
  create mode 100644 Documentation/devicetree/bindings/arm/bcm/kona-wdt.txt
  rename Documentation/devicetree/bindings/mmc/{bcm,kona-sdhci.txt => 
kona-sdhci.txt} (67%)
  create mode 100644 arch/arm/boot/dts/bcm28155-ap.dts
