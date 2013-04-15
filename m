From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 15 Apr 2013 15:00:19 -0400
Subject: [GIT PULL] mvebu dt (LPAE) for v3.10
Message-ID: <20130415190019.GS28693@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit b757f17e9184b65428c48a281d82f9acb3e96f0e:

  Merge tag 'tags/soc_for_v3.10' into mvebu/dt (2013-04-15 14:55:23 +0000)

are available in the git repository at:


  git://git.infradead.org/users/jcooper/linux.git tags/dt-3.10-4

for you to fetch changes up to 74898364e717c6bd939bb88d95049fc91d2b4950:

  ARM: dts: mvebu: Convert mvebu device tree files to 64 bits (2013-04-15 15:00:29 +0000)

----------------------------------------------------------------
mvebu dt for v3.10 round 4

 - mvebu LPAE 64bit dts file changes

Depends:
 - mvebu/fixes (tags/mvebu_fixes_for_v3.9_round3)
 - mvebu/soc (tags/soc_for_v3.10)

----------------------------------------------------------------
Gregory CLEMENT (3):
      ARM: dts: mvebu: Convert all the mvebu files to use the range property
      ARM: dts: mvebu: introduce internal-regs node
      ARM: dts: mvebu: Convert mvebu device tree files to 64 bits

Thomas Petazzoni (2):
      ARM: dts: mvebu: fix cpus section indentation
      ARM: dts: mvebu: move all peripherals inside soc

 arch/arm/boot/dts/armada-370-db.dts              | 134 +++----
 arch/arm/boot/dts/armada-370-mirabox.dts         | 176 +++++----
 arch/arm/boot/dts/armada-370-rd.dts              |  96 ++---
 arch/arm/boot/dts/armada-370-xp.dtsi             | 336 ++++++++--------
 arch/arm/boot/dts/armada-370.dtsi                | 330 ++++++++--------
 arch/arm/boot/dts/armada-xp-db.dts               | 202 +++++-----
 arch/arm/boot/dts/armada-xp-gp.dts               | 222 ++++++-----
 arch/arm/boot/dts/armada-xp-mv78230.dtsi         | 284 ++++++-------
 arch/arm/boot/dts/armada-xp-mv78260.dtsi         | 342 ++++++++--------
 arch/arm/boot/dts/armada-xp-mv78460.dtsi         | 484 ++++++++++++-----------
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts | 262 ++++++------
 arch/arm/boot/dts/armada-xp.dtsi                 | 202 +++++-----
 12 files changed, 1549 insertions(+), 1521 deletions(-)
