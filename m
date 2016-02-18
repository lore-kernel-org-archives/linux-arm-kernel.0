From: eric@anholt.net (Eric Anholt)
Date: Wed, 17 Feb 2016 18:56:48 -0800
Subject: [GIT PULL 2/2] bcm2835 changes to DT for 4.6
In-Reply-To: <1455764208-5679-1-git-send-email-eric@anholt.net>
References: <1455764208-5679-1-git-send-email-eric@anholt.net>
Message-ID: <1455764208-5679-2-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git at github.com:anholt/linux.git bcm2835-dt-next-2016-02-17

for you to fetch changes up to 1305141d1a7254b53b35303ee84f4c4948007bd0:

  ARM: bcm2835: add bcm2835-aux-uart support to DT (2016-02-17 11:01:00 -0800)

----------------------------------------------------------------
This pull request covers mostly DT changes that didn't make it into
4.5 because required header files went through other trees, plus the
AUX uart support this time around.

----------------------------------------------------------------
Alexander Aring (1):
      ARM: bcm2835: Add the Raspberry Pi power domain driver to the DT.

Lubomir Rintel (1):
      ARM: bcm2835: dt: Add Raspberry Pi Model A

Martin Sperl (3):
      ARM: bcm2835: add the auxiliary spi1 and spi2 to the device tree
      ARM: bcm2835: follow dt uart node-naming convention
      ARM: bcm2835: add bcm2835-aux-uart support to DT

Remi Pommarel (1):
      ARM: bcm2835: Add PWM clock support to the device tree

 arch/arm/boot/dts/Makefile          |  1 +
 arch/arm/boot/dts/bcm2835-rpi-a.dts | 24 +++++++++++++++++++++
 arch/arm/boot/dts/bcm2835-rpi.dtsi  | 16 ++++++++++++++
 arch/arm/boot/dts/bcm283x.dtsi      | 43 +++++++++++++++++++++++++++++++++++--
 4 files changed, 82 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm2835-rpi-a.dts
