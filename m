From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri,  9 Jan 2015 10:46:34 +0100
Subject: [GIT PULL] ARM: berlin: DT changes for v3.20 (round 1)
Message-ID: <1420796794-22767-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Kevin, Olof,

this is Marvell Berlin DT changes for v3.20. Again Jisheng Zhang from
Marvell did some improvements to Berlin SoCs by adding PMU nodes to
BG2Q and BG2CD and adding full PPI CPU masks to TWD timer interrupts.

Please pull.

Thanks,
  Sebastian

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.infradead.org/users/hesselba/linux-berlin.git tags/berlin-dt-for-3.20-1

for you to fetch changes up to 2356d2f3d1b742dacdeb1b0a038ec17f7cc2947f:

  ARM: dts: berlin: add PPI cpu mask to twd timer interrupts (2015-01-07 15:25:37 +0100)

----------------------------------------------------------------
Berlin DT changes for v3.20 (round 1)
- add PMU nodes for BG2Q and BG2CD
- add PPI CPU masks for TWD timer interrupts

----------------------------------------------------------------
Jisheng Zhang (2):
      ARM: dts: berlin: add pmu node for BG2Q and BG2CD
      ARM: dts: berlin: add PPI cpu mask to twd timer interrupts

 arch/arm/boot/dts/berlin2.dtsi   |  2 +-
 arch/arm/boot/dts/berlin2cd.dtsi |  7 ++++++-
 arch/arm/boot/dts/berlin2q.dtsi  | 10 +++++++++-
 3 files changed, 16 insertions(+), 3 deletions(-)
