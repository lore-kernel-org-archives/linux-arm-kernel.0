From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 28 May 2013 14:31:10 -0400
Subject: [GIT PULL] ARM: mvebu: fixes-non-critical for v3.11
Message-ID: <20130528183110.GZ31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof,

As asked, these were pulled out of mvebu/fixes.


The following changes since commit e4aa937ec75df0eea0bee03bffa3303ad36c986b:

  Linux 3.10-rc3 (2013-05-26 16:00:47 -0700)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/fixes-non-3.11-1

for you to fetch changes up to cf8088c5cac6ce20d914b9131533844b9291a054:

  arm: mvebu: fix length of Ethernet registers area in .dtsi (2013-05-28 14:48:28 +0000)

----------------------------------------------------------------
mvebu fixes non-critical for v3.11 (round 1)

 - mvebu
    - fix register area length in dtsi for ethernet and sata

----------------------------------------------------------------
Thomas Petazzoni (2):
      arm: mvebu: fix length of SATA registers area in .dtsi
      arm: mvebu: fix length of Ethernet registers area in .dtsi

 arch/arm/boot/dts/armada-370-xp.dtsi     | 6 +++---
 arch/arm/boot/dts/armada-xp-mv78460.dtsi | 2 +-
 arch/arm/boot/dts/armada-xp.dtsi         | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)
