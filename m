From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 14 Nov 2012 16:44:33 +0100
Subject: [GIT PULL] Marvell cleanup changes for the v3.8 merge window
Message-ID: <1352907876-32482-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 77b67063bb6bce6d475e910d3b886a606d0d91f7:

  Linux 3.7-rc5 (2012-11-11 13:44:33 +0100)

are available in the git repository at:

  git at github.com:MISL-EBU-System-SW/mainline-public.git tags/marvell-cleanups-for-3.8

for you to fetch changes up to 8c4340fcfb3e40372101a608ccd906e456ed3fcd:

  arm: mvebu: fix typo in machine name for Armada 370/XP (2012-11-14 16:35:10 +0100)

----------------------------------------------------------------
Marvell cleanups for 3.8

----------------------------------------------------------------
Thomas Petazzoni (3):
      arm: mvebu: fix compatible string in armada-370-xp.dtsi
      arm: mvebu: don't list all boards in dt compat field for Armada 370/XP
      arm: mvebu: fix typo in machine name for Armada 370/XP

 arch/arm/boot/dts/armada-370-xp.dtsi |    2 +-
 arch/arm/mach-mvebu/armada-370-xp.c  |    9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)
