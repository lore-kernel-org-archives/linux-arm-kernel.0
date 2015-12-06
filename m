From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun,  6 Dec 2015 11:37:12 +0100
Subject: [GIT PULL 3/3] ARM: berlin: DT changes for v4.5 (round 1)
In-Reply-To: <1449398232-13699-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1449398232-13699-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1449398232-13699-3-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Kevin, Olof,

this is the first round of Marvell Berlin DT changes for v4.5.
We have a few DT cleanups for eMMC and duplicated interrupt-parent
properties, watchdog nodes for all 32-bit Berlin SoCs, and full
SDHCI1 functionality on BG2Q DMP board.

Please pull.

Sebastian

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.infradead.org/users/hesselba/linux-berlin.git tags/berlin-dt-for-4.5-1

for you to fetch changes up to ac4111abf3521dfb3038c44c053f7c43ee1fb1bd:

  arm: dts: berlin2q-marvell-dmp: add sdhci1 fully functionality (2015-12-06 10:26:55 +0100)

----------------------------------------------------------------
Marvell Berlin DT changes (round 1):
- BG2Q cleanups (DMP eMMC, duplicated interrupt-parents)
- add BG2, BG2CD, BG2Q watchdog nodes
- add BG2Q DMP SDHCI1 nodes

----------------------------------------------------------------
Jisheng Zhang (6):
      arm: dts: berlin2q-marvell-dmp: remove broken-cd from eMMC node
      arm: dts: berlin2q: remove duplicated interrupt-parent
      arm: dts: berlin2q: add watchdog nodes
      arm: dts: berlin2cd: add watchdog nodes
      arm: dts: berlin2: add watchdog nodes
      arm: dts: berlin2q-marvell-dmp: add sdhci1 fully functionality

 arch/arm/boot/dts/berlin2.dtsi             | 23 ++++++++++++++++++
 arch/arm/boot/dts/berlin2cd.dtsi           | 23 ++++++++++++++++++
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts | 38 +++++++++++++++++++++++++++---
 arch/arm/boot/dts/berlin2q.dtsi            | 34 +++++++++++++++++++++-----
 4 files changed, 109 insertions(+), 9 deletions(-)
