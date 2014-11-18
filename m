From: xuwei5@hisilicon.com (Wei Xu)
Date: Tue, 18 Nov 2014 09:38:19 +0800
Subject: [GIT PULL RESEND]Hisilicon HiX5HD2 soc DT udaptes for v3.19
Message-ID: <546AA30B.20402@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Could you please help to merge pull request for hisilicon hix5hd2 soc dt updates for 3.19?
I have tested it and it is OK.
Thanks!

Best Regards,
Wei


The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hix5hd2-dt-for-3.19

for you to fetch changes up to 92cfcb26fca45aafa7eb9b8a4401a361caa88dec:

  ARM: dts: hix5hd2: add reboot node (2014-11-07 19:29:53 +0800)

----------------------------------------------------------------
ARM: DT:  Hisilicon terminal SoC HiX5HD2 DT updates for 3.19

- Add reboot node, reusing syscon-reboot
- Add I2C nodes Hisilicon IP
- Add IR node based on Hisilicon IP
- Add Watchdog node based on ARM IP
- Add GPIO nodes based on ARM GPIO IP
- Add SATA node based on Hisilicon IP
- Add USB nodes
- Add MMC nodes based on Synopsys IP
- Add GMAC nodes based on Hisilicon IP

----------------------------------------------------------------
Zhangfei Gao (9):
      ARM: dts: hix5hd2: add gmac node
      ARM: dts: hix5hd2: add mmc node
      ARM: dts: hix5hd2: add usb node
      ARM: dts: hix5hd2: add sata node
      ARM: dts: hix5hd2: add gpio node
      ARM: dts: hix5hd2: add wdg node
      ARM: dts: hix5hd2: add ir node
      ARM: dts: hix5hd2: add i2c node
      ARM: dts: hix5hd2: add reboot node

 arch/arm/boot/dts/hisi-x5hd2-dkb.dts |  33 ++++++++++++
 arch/arm/boot/dts/hisi-x5hd2.dtsi    | 390 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 421 insertions(+), 2 deletions(-)
