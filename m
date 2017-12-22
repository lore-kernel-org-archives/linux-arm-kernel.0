From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 22 Dec 2017 11:51:10 +0100
Subject: [GIT PULL] ARM: mvebu: dt for v4.16 (#1)
Message-ID: <87r2rndoip.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for dt for mvebu for v4.16.

Gregory

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.16-1

for you to fetch changes up to cea96bf1836f22d2586f650a0299bd37abf2d42e:

  arm: kirkwood: dts: Use lower case for bindings notation (2017-12-18 17:44:48 +0100)

----------------------------------------------------------------
mvebu dt for 4.16 (part 1)

Fix potential dtc warnings on kirkwoods files
Declare a new pin (RB) usbale for NAND controller on Armada 38x

----------------------------------------------------------------
Mathieu Malaterre (1):
      arm: kirkwood: dts: Use lower case for bindings notation

Sean Nyekjaer (1):
      ARM: dts: armada-38x: Add NAND RB pinctrl information

 arch/arm/boot/dts/armada-38x.dtsi            |  5 +++++
 arch/arm/boot/dts/kirkwood-linksys-viper.dts | 10 +++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)
