From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 11 Jun 2016 17:14:18 -0700
Subject: [PATCH] ARM: dts: sun7i: Add BCM53125 Device Tree nodes
Message-ID: <1465690459-30751-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patch adds the Device Tree nodes to support the BCM53125 switch hanging
off the GMAC MDIO bus on the Lamobo R1 board.

The B53 driver has been accepted into net-next just recently:

https://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git/commit/?id=23c731e830009a51a39a7a558179007235c84eb7

Florian Fainelli (1):
  ARM: dts: sun7i: Add BCM53125 Device Tree nodes

 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts | 60 +++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 3 deletions(-)

-- 
2.7.4
