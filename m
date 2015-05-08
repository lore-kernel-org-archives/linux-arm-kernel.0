From: xuwei5@hisilicon.com (Wei Xu)
Date: Fri, 8 May 2015 15:26:09 +0100
Subject: [GIT PULL]Hisilicon hip04 soc and D01 board DT updates for v4.2
Message-ID: <554CC781.9010705@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof, Hi Kevin,

Please help to merge pull request for hisilicon hip04 soc and
D01 board DT updates for v4.2.

Thanks!

Best Regards,
Wei

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hip04-dt-for-4.2

for you to fetch changes up to 9fac45c16c33f9f822ed7f9b9660890f68f16d8b:

  ARM: dts: add HiSilicon hip04 ethernet controller resource (2015-05-08 01:57:51 +0100)

----------------------------------------------------------------
ARM: DT: Hisilicon hip04 soc and D01 board updates for 4.2

- Add hip04 GPIO nodes
- Add NANDC nodes for hip04 and D01 board
- Add hip04 ethernet related nodes

----------------------------------------------------------------
Fathi Boudra (1):
      ARM: dts: add HiSilicon hip04 ethernet controller resource

Zhou Wang (2):
      ARM: dts: hip04: add GPIO pieces
      mtd: hisilicon: add device tree node for NAND controller

 arch/arm/boot/dts/hip04-d01.dts |  27 +++++++++++++++++++++++++++
 arch/arm/boot/dts/hip04.dtsi    | 133 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 160 insertions(+)
