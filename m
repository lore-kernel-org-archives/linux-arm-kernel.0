From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 20 Jul 2018 10:54:25 +0200
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.19 (#2)
Message-ID: <87sh4e8eym.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for dt64 for mvebu for v4.19.

Gregory

The following changes since commit 4436a3711e3249840e0679e92d3c951bcaf25515:

  arm64: dts: marvell: armada-37xx: reserve memory for ATF (2018-06-29 16:39:03 +0200)

are available in the Git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.19-2

for you to fetch changes up to c462f6c77e72804b72e008a91c4b6fa8d9b4b265:

  arm64: dts: marvell: armada-37xx: update the crypto engine compatible (2018-07-13 13:42:03 +0200)

----------------------------------------------------------------
mvebu dt64 for 4.19 (part 2)

Use more specific compatible for the Inside Secure SafeXcel on the
Armada 37xx and the Armada 7K/8K SoCs.

----------------------------------------------------------------
Antoine Tenart (2):
      arm64: dts: marvell: armada-cp110: update the crypto engine compatible
      arm64: dts: marvell: armada-37xx: update the crypto engine compatible

 arch/arm64/boot/dts/marvell/armada-37xx.dtsi  | 2 +-
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
