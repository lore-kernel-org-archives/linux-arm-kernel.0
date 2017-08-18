From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Aug 2017 11:44:02 +0200
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.14 (#2)
Message-ID: <87mv6xky71.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for dt64 for mvebu for v4.14.

Gregory

The following changes since commit 249112cef2f323354be61a27be1d6e94507f7587:

  arm64: dts: marvell: re-order RTC nodes in Marvell CP110 description (2017-08-02 16:07:38 +0200)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.14-2

for you to fetch changes up to 0ea62502a5146cfe98696a152894ebb9afbee9d4:

  ARM64: dts: marvell: enable USB host on Armada-8040-DB (2017-08-14 16:30:43 +0200)

----------------------------------------------------------------
mvebu dt64 for 4.14 (part 2)

- Enable uSD on ESPRESSObin (Armada 37xx based board)
- Add NAND support on Armada 7K/8K SoCs
- Enable USB host on Armada-7040-DB and Armada-8040-DB boards

----------------------------------------------------------------
Gregory CLEMENT (2):
      arm64: dts: marvell: Fully re-order nodes in Marvell CP110 dtsi files
      ARM64: dts: marvell: add NAND support on the CP110

Grzegorz Jaszczyk (1):
      ARM64: dts: marvell: enable USB host on Armada-8040-DB

Hanna Hawa (1):
      ARM64: dts: marvell: enable USB host on Armada-7040-DB

Marcin Wojtas (1):
      ARM64: dts: marvell: armada-37xx: Enable uSD on ESPRESSObin

 .../boot/dts/marvell/armada-3720-espressobin.dts   | 25 +++++++++
 arch/arm64/boot/dts/marvell/armada-7040-db.dts     | 39 +++++++++++++
 arch/arm64/boot/dts/marvell/armada-8040-db.dts     | 65 ++++++++++++++++++++++
 .../boot/dts/marvell/armada-cp110-master.dtsi      | 33 ++++++++---
 .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi | 33 ++++++++---
 5 files changed, 177 insertions(+), 18 deletions(-)
