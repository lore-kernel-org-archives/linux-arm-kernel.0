From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 30 Jul 2013 17:44:49 +0200
Subject: [PATCH 0/2] Add support for a new Armada XP based board
Message-ID: <1375199091-31215-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The following two patches add support for a new Armada-XP board. The
first patch adds the DTS file, the second patch updates the
mvebu_defconfig file with some more interesting options.

Thanks,

Thomas

Thomas Petazzoni (2):
  ARM: mvebu: add support for the AXP WiFi AP board
  ARM: mvebu: add gpio-keys and input event support in defconfig

 arch/arm/boot/dts/Makefile                |   1 +
 arch/arm/boot/dts/armada-xp-axpwifiap.dts | 164 ++++++++++++++++++++++++++++++
 arch/arm/configs/mvebu_defconfig          |   2 +
 3 files changed, 167 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-xp-axpwifiap.dts

-- 
1.8.1.2
