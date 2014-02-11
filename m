From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 11 Feb 2014 18:07:10 +0100
Subject: [PATCH 0/3] Minor Armada 370/XP cleanups
Message-ID: <1392138433-12573-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason, Greg, Andrew, Sebastian,

Here are three minor cleanups, the first one for mvebu/soc, the two
other ones for mvebu/dt. I believe they are fairly self-explanatory.

Thanks!

Thomas

Thomas Petazzoni (3):
  ARM: mvebu: remove unneeded ->map_io field for Armada 370/XP
  ARM: mvebu: use GPIO DT defines in Armada 370/XP boards
  ARM: mvebu: use input DT defines in Armada 370/XP boards

 arch/arm/boot/dts/armada-370-mirabox.dts         |  7 ++++---
 arch/arm/boot/dts/armada-370-rd.dts              |  6 ++++--
 arch/arm/boot/dts/armada-xp-axpwifiap.dts        |  6 ++++--
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts | 12 +++++++-----
 arch/arm/mach-mvebu/armada-370-xp.c              |  6 ------
 5 files changed, 19 insertions(+), 18 deletions(-)

-- 
1.8.3.2
