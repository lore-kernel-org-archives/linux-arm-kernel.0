From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 10 Nov 2016 22:49:06 +0100
Subject: [GIT PULL] ARM: mvebu: fixes for v4.9 (#1)
Message-ID: <87twbfc8fh.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for fixes for mvebu for v4.9.

Gregory

The following changes since commit bc33b0ca11e3df467777a4fa7639ba488c9d4911:

  Linux 4.9-rc4 (2016-11-05 16:23:36 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.9-1

for you to fetch changes up to 8d897006fe9206d64cbe353310be26d7c911e69d:

  arm64: dts: marvell: add unique identifiers for Armada A8k SPI controllers (2016-11-09 09:44:08 +0100)

----------------------------------------------------------------
mvebu fixes for 4.9 (part 1)

All of them are fixes for arm64 device tree

- 2 for the SPI node on the Armada 7K/8K
- 1 for the clock node on the Armada 37xx

----------------------------------------------------------------
Gregory CLEMENT (1):
      arm64: dts: marvell: Fix typo in label name on Armada 37xx

Marcin Wojtas (2):
      arm64: dts: marvell: fix clocksource for CP110 slave SPI0
      arm64: dts: marvell: add unique identifiers for Armada A8k SPI controllers

 arch/arm64/boot/dts/marvell/armada-37xx.dtsi        | 4 ++--
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)
