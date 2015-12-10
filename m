From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 10 Dec 2015 21:12:57 +0100
Subject: [GIT PULL] ARM: berlin: Fixes for v4.4-rc1 (round 1)
Message-ID: <1449778377-8720-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Kevin, Olof,

this is the first round of Marvell Berlin fixes for v4.4-rc1.
This fixes an issue with BG2Q SDIO clocks that have been changed
in v4.4-rc1 while the corresponding DT change didn't make it in
time.

Please pull.

Sebastian

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.infradead.org/users/hesselba/linux-berlin.git tags/berlin-fixes-for-4.4-rc1-1

for you to fetch changes up to b5010d2081331e1c95358c4eb500bd30f5d532ce:

  ARM: dts: berlin: add 2nd clock for BG2Q sdhci0 and sdhci1 (2015-12-10 21:00:24 +0100)

----------------------------------------------------------------
Marvell Berlin fixes for 4.4-rc1 (round 1)
- fix wrong SDIO DT clocks on BG2Q

----------------------------------------------------------------
Jisheng Zhang (2):
      ARM: dts: berlin: correct BG2Q's sdhci2 2nd clock
      ARM: dts: berlin: add 2nd clock for BG2Q sdhci0 and sdhci1

 arch/arm/boot/dts/berlin2q.dtsi | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)
