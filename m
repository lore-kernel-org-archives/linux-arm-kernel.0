From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 04 Jul 2016 22:49:27 +0200
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.8 (#1)
Message-ID: <87zipxuo14.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for dt64 for mvebu for v4.8.

Gregory

The following changes since commit 19b67d5c8b2dbef9a10bc1aeb96a861c57a0bdf8:

  arm64: dts: marvell: add XOR node for Armada 3700 SoC (2016-04-29 15:07:42 +0200)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.8-1

for you to fetch changes up to 5f4beef6db3c158ed99573d74e93dfe0611352e4:

  arm64: dts: marvell: add peripherals clocks for Armada 37xx (2016-07-04 22:21:13 +0200)

----------------------------------------------------------------
mvebu dt64 for 4.8 (part 1)

- update dt with mv-xor-v2 found in the Armada 7K/8K SoCs
- update dt with the clocks found in the Armada 3700 SoCs

----------------------------------------------------------------
Gregory CLEMENT (3):
      arm64: dts: marvell: Add xtal clock support for Armada 3700
      arm64: dts: marvell: add tbg clocks for Armada 37xx
      arm64: dts: marvell: add peripherals clocks for Armada 37xx

Thomas Petazzoni (2):
      arm64: dts: marvell: adjust to the latest mv-xor-v2 DT binding
      arm64: dts: marvell: add XOR engine description for Armada 7K/8K CP

 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       | 35 ++++++++++++++++++++++
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |  8 ++---
 .../boot/dts/marvell/armada-cp110-master.dtsi      | 18 +++++++++++
 3 files changed, 57 insertions(+), 4 deletions(-)
