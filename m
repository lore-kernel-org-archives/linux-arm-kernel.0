From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 31 Jan 2013 15:08:05 +0100
Subject: [PATCH v2] Adding support for the new Armada XP development board
 from Marvell
Message-ID: <1359641286-18182-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is the second version of a single patch to add the dts support
for new Armada XP development board from Marvell called
DB-MV784MP-GP.

Simon Guinot and Florian Fainelli tested it successfully the issue I
get with Ethernet so it should be hardware related.

Since the first version, beside adding the tested-by flag, I also
fixed the name for the board. The name of this board start by DB for
development board so let's use it!

The other change was about the memory node: I had some comments to
emphasize that the amount of memory may change.

Thanks,

Gregory CLEMENT (1):
  arm: mvebu: support for the new Armada XP development
    board(DB-MV784MP-GP)

 arch/arm/boot/dts/Makefile         |    1 +
 arch/arm/boot/dts/armada-xp-gp.dts |  101 ++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-xp-gp.dts

-- 
1.7.9.5
