From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 01 Jun 2017 17:06:35 +0200
Subject: [GIT PULL] ARM: mvebu: fixes for v4.12 (#1)
Message-ID: <87d1ansq6c.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for fixes for mvebu for v4.12.

Gregory

The following changes since commit 08332893e37af6ae779367e78e444f8f9571511d:

  Linux 4.12-rc2 (2017-05-21 19:30:23 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.12-1

for you to fetch changes up to 44f73dc42c11398d7b84e94365a485ebd6420798:

  arm64: marvell: dts: fix interrupts in 7k/8k crypto nodes (2017-05-24 17:12:59 +0200)

----------------------------------------------------------------
mvebu fixes for 4.12

Fix the interrupt description of the crypto node for device tree of
the Armada 7K/8K SoCs

----------------------------------------------------------------
Antoine Tenart (1):
      arm64: marvell: dts: fix interrupts in 7k/8k crypto nodes

 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 3 +--
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)
