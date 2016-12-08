From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 08 Dec 2016 17:22:32 +0100
Subject: [GIT PULL] ARM: mvebu: fixes for v4.9 (#2)
Message-ID: <87r35ifl13.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for fixes for mvebu for v4.9.

Gregory

The following changes since commit 8d897006fe9206d64cbe353310be26d7c911e69d:

  arm64: dts: marvell: add unique identifiers for Armada A8k SPI controllers (2016-11-09 09:44:08 +0100)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.9-2

for you to fetch changes up to b150e59f1d217473b3eab354a9e5e9fe907868ff:

  ARM: dts: orion5x: fix number of sata port for linkstation ls-gl (2016-12-05 16:43:05 +0100)

----------------------------------------------------------------
mvebu fixes for 4.9 (part 2)

Fix number of sata port for linkstation ls-gl: without this the hard
drive is not detected as it was before the dt conversion

----------------------------------------------------------------
Roger Shimizu (1):
      ARM: dts: orion5x: fix number of sata port for linkstation ls-gl

 arch/arm/boot/dts/orion5x-linkstation-lsgl.dts | 4 ++++
 1 file changed, 4 insertions(+)
