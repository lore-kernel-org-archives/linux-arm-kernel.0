From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 28 Dec 2012 15:08:47 +0100
Subject: [PATCH 0/3] Convert more of NSA310 to DT.
Message-ID: <1356703730-4926-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset converts more of the NSA310 into device tree.

Currently untested.

Andrew Lunn (3):
  ARM: Kirkwood: Convert NSA310 to DT based regulators.
  ARM: Kirkwood: Convert NSA310 to use gpio-poweroff driver
  ARM: Kirkwood: Convert NSA310 I2C to device tree

 arch/arm/boot/dts/kirkwood-nsa310.dts |   27 +++++++++++++++++++++
 arch/arm/mach-kirkwood/board-nsa310.c |   43 ---------------------------------
 2 files changed, 27 insertions(+), 43 deletions(-)

-- 
1.7.10.4
