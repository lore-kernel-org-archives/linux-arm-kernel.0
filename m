From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri,  9 Jan 2015 10:39:25 +0100
Subject: [GIT PULL] ARM: berlin: Fixes for v3.19 (round 1)
Message-ID: <1420796365-22563-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Kevin, Olof,

this is Marvell Berlin fixes for v3.19, where Jisheng Zhang from Marvell
discovered some SDHCI DT issues and mislocated SM GPIO nodes for BG2Q.
All individual patches also have been tagged for stable up to 3.16 where
BG2Q support appeared first.

Please pull.

Thanks,
  Sebastian

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.infradead.org/users/hesselba/linux-berlin.git tags/berlin-fixes-for-3.19-1

for you to fetch changes up to 5138d5c562e3bfe30964e20ab46eec9f8b89225d:

  ARM: dts: berlin: correct BG2Q's SM GPIO location. (2015-01-07 15:36:44 +0100)

----------------------------------------------------------------
Marvell Berlin fixes for v3.19 round 1:
- SDHCI DT fixes for BG2Q and BG2Q reference board
- BG2Q SM GPIO DT node relocation

----------------------------------------------------------------
Jisheng Zhang (3):
      ARM: dts: berlin: fix io clk and add missing core clk for BG2Q sdhci2 host
      ARM: dts: berlin: add broken-cd and set bus width for eMMC in Marvell DMP DT
      ARM: dts: berlin: correct BG2Q's SM GPIO location.

 arch/arm/boot/dts/berlin2q-marvell-dmp.dts |  2 +
 arch/arm/boot/dts/berlin2q.dtsi            | 63 +++++++++++++++---------------
 2 files changed, 34 insertions(+), 31 deletions(-)
