From: xuwei5@hisilicon.com (xuwei)
Date: Tue, 16 Sep 2014 14:22:54 +0800
Subject: [GIT PULL][for 3.18]pull request for hisilicon hix5hd2 soc dt updates
Message-ID: <5417D73E.8080309@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please help to merge pull request for hisilicon hix5hd2 soc dt updates for 3.18. 
Thanks!

Best Regards,
Wei


The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hix5hd2-dt-for-3.18

for you to fetch changes up to 610bd8722ef40b649b51f01045c5d1903f41b583:

  ARM: dts: hix5hd2: add wdg node (2014-09-16 11:00:43 +0800)

----------------------------------------------------------------
ARM: DT:  Hisilicon terminal SoC HiX5HD2 DT updates for 3.18

- Add watchdog, gpio, sata, usb, mmc and gmac nodes in HiX5HD2 SoC DT
- Enable sata and gmac in HiX5HD2 dkb board DT

----------------------------------------------------------------
Zhangfei Gao (6):
      ARM: dts: hix5hd2: add gmac node
      ARM: dts: hix5hd2: add mmc node
      ARM: dts: hix5hd2: add usb node
      ARM: dts: hix5hd2: add sata node
      ARM: dts: hix5hd2: add gpio node
      ARM: dts: hix5hd2: add wdg node

 arch/arm/boot/dts/hisi-x5hd2-dkb.dts |  33 +++++++++++++++
 arch/arm/boot/dts/hisi-x5hd2.dtsi    | 310 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 343 insertions(+)
