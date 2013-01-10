From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 10 Jan 2013 03:28:10 +0000
Subject: [GIT PULL] ARM: mvebu fixes for v3.8-rc3
Message-ID: <mailman.22.1357788495.1035.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ba607b6238a1f418c45b9d7f73212bcc6922da53:

  pinctrl: mvebu: make pdma clock on dove mandatory (2013-01-07 16:19:02 +0000)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/mvebu_fixes_for_v3.8-rc3

for you to fetch changes up to 9e1c96ed82562c05c89ee3eedee8d980e5c0d865:

  ARM: Dove: add Cubox sdhci card detect gpio (2013-01-10 02:14:08 +0000)

----------------------------------------------------------------
mvebu fixes for v3.8-rc3
 - gpio fixes in mvebu, kirkwood, and dove

----------------------------------------------------------------
Sebastian Hesselbarth (1):
      ARM: Dove: add Cubox sdhci card detect gpio

Simon Guinot (1):
      ARM: Kirkwood: fix ns2 gpios by converting to pinctrl

Thomas Petazzoni (1):
      arm: mvebu: use global interrupts for GPIOs on Armada XP

 arch/arm/boot/dts/armada-xp-mv78230.dtsi   | 14 +++++------
 arch/arm/boot/dts/armada-xp-mv78260.dtsi   | 21 +++++++----------
 arch/arm/boot/dts/armada-xp-mv78460.dtsi   | 21 +++++++----------
 arch/arm/boot/dts/dove-cubox.dts           | 14 +++++++++--
 arch/arm/boot/dts/kirkwood-ns2-common.dtsi | 16 +++++++++++++
 arch/arm/mach-kirkwood/board-ns2.c         | 38 ------------------------------
 6 files changed, 52 insertions(+), 72 deletions(-)
