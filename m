From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 27 Jan 2016 16:24:45 +0100
Subject: [PATCH 0/2] ARM: mvebu: misc DT improvements
Message-ID: <1453908287-29557-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Here are two fixes/improvements for Marvell EBU platforms, which were
initially sent on June 18th 2015, and never got any feedback.

This new iteration is simply rebased on v4.5-rc1 with no other
changes.

Thanks!

Thomas

Lior Amsalem (1):
  ARM: mvebu: use armada-370-sata for SATA on Armada 375

Thomas Petazzoni (1):
  ARM: mvebu: add NAND description to Armada 370 DB and Armada XP DB

 arch/arm/boot/dts/armada-370-db.dts | 21 +++++++++++++++++++++
 arch/arm/boot/dts/armada-375.dtsi   |  2 +-
 arch/arm/boot/dts/armada-xp-db.dts  | 21 +++++++++++++++++++++
 3 files changed, 43 insertions(+), 1 deletion(-)

-- 
2.6.4
