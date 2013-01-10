From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 10 Jan 2013 22:01:07 +0100
Subject: [PATCH 0/2] Remove two redundent clk aliases
Message-ID: <1357851669-25669-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both USB and MDIO are now instantiated using DT and these DT nodes
have clocks properties. Remove the now redundant clkdev aliases.

The first patch has no dependencies.

The second patch is dependent on the SDIO patchset "Device Tree
binding for the mvsdio driver" by Thomas Petazzoni.


Andrew Lunn (2):
  ARM: Kirkwood: Remove redundent USB clock alias
  ARM: Kirkwood: Remove redundent SDIO clock alias

 arch/arm/mach-kirkwood/board-dt.c |    9 ---------
 1 file changed, 9 deletions(-)

-- 
1.7.10.4
