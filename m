From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 30 Jan 2013 18:26:13 +0100
Subject: [PATCH] Adding support for the new Armada XP evaluation board from
 Marvell
Message-ID: <1359566774-27669-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This single patch add the dts support for new Armada XP evaluation
board from Marvell called DB-MV784MP-GP. I am a little annoyed because
on my board the Ethernet don't work under Linux (it works with
U-Boot). However Florian Fainelli had more chance with the same board
and managed to have a fully working Ethernet for the 4 ports. I would
not miss the 3.9 kernel just because of a hardware problem on my side.

As Simon Guinot have also the same board and is interested by running
a mainline Linux kernel on it, I hope he will be able to test it,
soon. If I get the tested-by from Florian and Simon, we can consider
that the support is OK, and it is my board which have a hardware
problem.

Thanks,

Gregory CLEMENT (1):
  arm: mvebu: support for the new Armada XP evaluation
    board(DB-MV784MP-GP)

 arch/arm/boot/dts/Makefile         |    1 +
 arch/arm/boot/dts/armada-xp-gp.dts |   94 ++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-xp-gp.dts

-- 
1.7.9.5
