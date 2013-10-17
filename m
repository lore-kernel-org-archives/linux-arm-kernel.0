From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 17 Oct 2013 09:59:50 -0400
Subject: [GIT PULL] ARM: mvebu: dt changes for v3.13 (round 3)
Message-ID: <20131017135950.GH22434@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

Nothing exciting here, just making dove better. :)

thx,

Jason.


The following changes since commit 7837feff0d881835309fced7a7c4b5f32866d632:

  arm: mvebu: add support for the Armada XP Matrix board (2013-10-03 15:13:01 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/dt-3.13-3

for you to fetch changes up to 1deb122c724edfd799a4d7d0b88ff14c365c9e69:

  ARM: Dove: fix bad properties of the si5351 clkout2 used by Cubox audio (2013-10-09 13:22:41 +0000)

----------------------------------------------------------------
mvebu dt changes for v3.13 (round 3)

 - dove
    - add audio devices
    - fix bad properties of si5351 clkout2 for CuBox

----------------------------------------------------------------
Jean-Francois Moine (3):
      ARM: Dove: Add the audio devices in DT
      ARM: Dove: Add the audio device to the Cubox DT
      ARM: Dove: fix bad properties of the si5351 clkout2 used by Cubox audio

 arch/arm/boot/dts/dove-cubox.dts | 18 ++++++++++--------
 arch/arm/boot/dts/dove.dtsi      | 28 ++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 8 deletions(-)
