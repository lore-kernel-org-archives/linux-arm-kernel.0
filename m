From: eric@anholt.net (Eric Anholt)
Date: Mon,  8 Feb 2016 16:32:58 -0800
Subject: [GIT PULL] bcm2835 DT changes for 4.6
Message-ID: <1454977978-17491-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian.  Here's the first set of patches for bcm2835 for 4.6.
We've got more DT patches that are going to happen for new boards,
too, but they're still getting polished.

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git at github.com:anholt/linux.git tags/bcm2835-dt-next-2016-02-04

for you to fetch changes up to 5ec6f2cd8ec4bcd38ba199ea8711a5ec906d85e7:

  ARM: bcm2835: Add the Raspberry Pi power domain driver to the DT. (2016-02-02 20:02:45 -0800)

----------------------------------------------------------------
This pull request covers mostly DT changes that didn't make it into
4.5 because required header files went through other trees.

----------------------------------------------------------------
Alexander Aring (1):
      ARM: bcm2835: Add the Raspberry Pi power domain driver to the DT.

Lubomir Rintel (1):
      ARM: bcm2835: dt: Add Raspberry Pi Model A

Martin Sperl (2):
      ARM: bcm2835: add the auxiliary spi1 and spi2 to the device tree
      ARM: bcm2835: follow dt uart node-naming convention

Remi Pommarel (1):
      ARM: bcm2835: Add PWM clock support to the device tree

 arch/arm/boot/dts/Makefile          |  1 +
 arch/arm/boot/dts/bcm2835-rpi-a.dts | 24 ++++++++++++++++++++++++
 arch/arm/boot/dts/bcm2835-rpi.dtsi  | 16 ++++++++++++++++
 arch/arm/boot/dts/bcm283x.dtsi      | 35 +++++++++++++++++++++++++++++++++--
 4 files changed, 74 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm2835-rpi-a.dts
