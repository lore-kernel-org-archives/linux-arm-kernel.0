From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 1 Dec 2013 12:16:49 -0500
Subject: [GIT PULL] ARM: mvebu: DT fixes for v3.13
Message-ID: <20131201171649.GU2879@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

Here's a round of DT fixes for v3.13.  They've all been in -next at
least five days.  (Yes, I know they only need to be in -next a day or
two, my schedule got away from me :) ).

thx,

Jason.


The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-fixes-3.13

for you to fetch changes up to 96039f735e290281d0c8a08fc467de2cd610543d:

  ARM: mvebu: re-enable PCIe on Armada 370 DB (2013-11-25 18:24:36 +0000)

----------------------------------------------------------------
mvebu DT fixes for v3.13

 - mvebu
    - PCIe fixes now that we have test devices with more ports.
    - fix access to coherency registers

----------------------------------------------------------------
Arnaud Ebalard (2):
      ARM: mvebu: second PCIe unit of Armada XP mv78230 is only x1 capable
      ARM: mvebu: fix second and third PCIe unit of Armada XP mv78260

Gregory CLEMENT (1):
      ARM: mvebu: use the virtual CPU registers to access coherency registers

Thomas Petazzoni (1):
      ARM: mvebu: re-enable PCIe on Armada 370 DB

 arch/arm/boot/dts/armada-370-db.dts      |  28 ++++----
 arch/arm/boot/dts/armada-370-xp.dtsi     |   2 +-
 arch/arm/boot/dts/armada-xp-mv78230.dtsi |  24 +++----
 arch/arm/boot/dts/armada-xp-mv78260.dtsi | 109 ++++++++++++++++++++++++-------
 4 files changed, 112 insertions(+), 51 deletions(-)
