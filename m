From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 31 Jan 2013 15:50:11 +0100
Subject: [PATCH v3] Adding support for the new Armada XP development board
 from Marvell
Message-ID: <1359643812-32654-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is the third version (and hopefully the last) of a single patch
to add the dts support for new Armada XP development board from
Marvell called DB-MV784MP-GP.

The branch GP-board is available at
https://github.com/MISL-EBU-System-SW/mainline-public.git

Changelog:

V2->v3
- fixed typos in comments
- fixed the compatible string for the board and use marvell,axp-gp
  instead of marvell,axp-db which was already used by an other board
- fixed the model name by remove the colon

v2->v1:
- added tested-by from Simon Guinot and Florian Fainelli
- added some comments to emphasize that the amount of memory may
  change.
- named the board ``development board''

Gregory CLEMENT (1):
  arm: mvebu: support for the new Armada XP development
    board(DB-MV784MP-GP)

 arch/arm/boot/dts/Makefile         |    1 +
 arch/arm/boot/dts/armada-xp-gp.dts |  101 ++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-xp-gp.dts

-- 
1.7.9.5
