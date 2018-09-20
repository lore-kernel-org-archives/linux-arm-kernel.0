From: joel@jms.id.au (Joel Stanley)
Date: Thu, 20 Sep 2018 18:18:09 +0930
Subject: [GIT PULL] ARM: aspeed: dts changes for 4.20
Message-ID: <CACPK8XfwK85_os-Kjqvkwp-V8YqV3JDPZEepdgXNA+6ievOLSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello ARM Maintainers,

Here's the ASPEED device tree changes for 4.20. Please pull if they
look good. Thanks!

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git \
    tags/aspeed-4.20-devicetree

for you to fetch changes up to 3368e06e2a91a65cff59e520acc51b9adf4900bf:

  ARM: dts: aspeed: Adding Facebook TiogaPass BMC (2018-09-20 17:25:48 +0930)

----------------------------------------------------------------
ASPEED device tree updates for 4.20

 - Two new ast2500-based machines:

   * Facebook TiogaPass (x86 server)
   * HXT StarDragon 4800 Reference Evaluation Platform 2 (arm64 server)

 - Updates for the Quanta q71l system

 - i2c device tree cleanups

----------------------------------------------------------------
Patrick Venture (3):
      ARM: dts: aspeed: quanta-q71l: add aliases for i2c
      ARM: dts: aspeed: quanta-q71l: Add four PSUs
      ARM: dts: aspeed: quanta-q71l: Enable adc & ibt nodes

Rob Herring (1):
      ARM: dts: aspeed: Fix I2C bus warnings

Vijay Khemka (1):
      ARM: dts: aspeed: Adding Facebook TiogaPass BMC

Yuan Yao (1):
      ARM: dts: aspeed: Add HXT StarDragon 4800 REP2 BMC

 arch/arm/boot/dts/Makefile                         |   2 +
 .../dts/aspeed-bmc-arm-stardragon4800-rep2.dts     | 207 +++++++++++++++++++++
 .../arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts | 146 +++++++++++++++
 arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts       |  47 +++++
 arch/arm/boot/dts/aspeed-g4.dtsi                   |   2 +-
 arch/arm/boot/dts/aspeed-g5.dtsi                   |   2 +-
 6 files changed, 404 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
