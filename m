From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 03 Feb 2017 10:47:16 +0100
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.11 (#3)
Message-ID: <87h94bwqqj.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the third pull request for dt64 for mvebu for v4.11.
(I forgot to send this one with the other on Tuesday).

Gregory

The following changes since commit 7292ff67b9b28feb3bef97b437f08c7e7568786f:

  arm64: dts: marvell: add generic-ahci compatibles for CP110 ahci (2017-01-27 11:13:01 +0100)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.11-3

for you to fetch changes up to d0979c07ff52a316aa762ac749ba6377b2c10d61:

  arm64: dts: marvell: adjust name of sd-mmc-gop clock in syscon (2017-01-31 11:51:45 +0100)

----------------------------------------------------------------
mvebu dt for 4.11 (part 3)

adjust name of sd-mmc-gop clock in sysco for Armada 7K/8K

----------------------------------------------------------------
Thomas Petazzoni (1):
      arm64: dts: marvell: adjust name of sd-mmc-gop clock in syscon

 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 2 +-
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
