From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat,  6 Jun 2015 18:34:28 -0700
Subject: [GIT PULL] Broadcom Device Tree changes for 4.2 (part 3)
Message-ID: <1433640869-12746-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 9d7ef1b76c131f9b5e0a31fd1444d4fa6b8a841c:

  ARM: dts: BCM63xx: re-parent NAND controller node (2015-05-27 09:57:34 -0700)

are available in the git repository at:

  https://github.com/Broadcom/stblinux tags/arm-soc/for-4.2/dts-part3

for you to fetch changes up to 26343bdacfcdbf6ee3303d6078a015b908f90193:

  ARM: BCM5301X: Add DT for Asus RT-AC87U (2015-06-06 16:13:16 -0700)

----------------------------------------------------------------
This pull request contains Broadcom BCM5301x related changes:

- Hauke adds the interrupt mapping for the BCM5301x PCIe controller

- Haule adds support for NAND flash using the standard Broadcom NAND controller
  iProc specific binding on BCM4708/5301x

- Rafal adds support for the Asus RT-AC87U router

----------------------------------------------------------------
Hauke Mehrtens (2):
      ARM: BCM5301X: add NAND flash chip description
      ARM: BCM5301X: add IRQ numbers for PCIe controller

Rafa? Mi?ecki (1):
      ARM: BCM5301X: Add DT for Asus RT-AC87U

 arch/arm/boot/dts/Makefile                         |  1 +
 arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts        |  1 +
 arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts        |  1 +
 arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts  |  1 +
 arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts       |  9 +--
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts        |  1 +
 arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts     |  1 +
 arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts      |  1 +
 arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts        |  1 +
 arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts |  1 +
 arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts  |  1 +
 arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts        | 65 ++++++++++++++++++++++
 arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts  |  1 +
 arch/arm/boot/dts/bcm4709-netgear-r8000.dts        |  1 +
 arch/arm/boot/dts/bcm5301x-nand-cs0-bch8.dtsi      | 24 ++++++++
 arch/arm/boot/dts/bcm5301x.dtsi                    | 36 ++++++++++++
 16 files changed, 140 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts
 create mode 100644 arch/arm/boot/dts/bcm5301x-nand-cs0-bch8.dtsi
