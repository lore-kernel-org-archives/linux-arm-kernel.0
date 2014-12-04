From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Thu, 04 Dec 2014 21:11:56 +0100
Subject: [GIT PULL] ARM: BCM5301X: DT changes for v3.19 #2
Message-ID: <5480C00C.3090709@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

This is a late pull request with some dts updates for BCM5301X I hope
this still can go into 3.19.

It is based onto of my last dt pull request for BCM5301X.


The following changes since commit dd6d2e5f4bbb828268506e9d6b772fffe101e76c:

  ARM: BCM5301X: Add LEDs for Netgear R6250 V1 (2014-11-27 22:30:32 +0100)

are available in the git repository at:

  https://github.com/hauke/linux.git tags/bcm5301x-dt-2014-12-04

for you to fetch changes up to dd7733da69f198f576d7f52f6bc5a860fe24930d:

  ARM: BCM5301X: Add DT for Buffalo WZR-600DHP2 (2014-12-04 20:58:11 +0100)

----------------------------------------------------------------
ARM: BCM5301X: dts updates

This adds the IRQ number to the main dts file and some new dts files
for newly added devices.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

----------------------------------------------------------------
Hauke Mehrtens (1):
      ARM: BCM5301X: Add IRQs to Broadcom's bus-axi in DTS file

Rafa? Mi?ecki (5):
      ARM: BCM5301X: Add buttons for Netgear R6250
      ARM: BCM5301X: Add DT for Netgear R6300 V2
      ARM: BCM5301X: Add DT for Buffalo WZR-1750DHP
      ARM: BCM5301X: Add DT for Asus RT-N18U
      ARM: BCM5301X: Add DT for Buffalo WZR-600DHP2

 arch/arm/boot/dts/Makefile                         |  7 +-
 arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts  | 64 +++++++++++++++++
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts        | 25 +++++++
 arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts     | 84
++++++++++++++++++++++
 arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts        | 78
++++++++++++++++++++
 arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts | 57 +++++++++++++++
 arch/arm/boot/dts/bcm47081.dtsi                    | 26 +++++++
 arch/arm/boot/dts/bcm5301x.dtsi                    | 35 +++++++++
 8 files changed, 375 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
 create mode 100644 arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
 create mode 100644 arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
 create mode 100644 arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
 create mode 100644 arch/arm/boot/dts/bcm47081.dtsi
