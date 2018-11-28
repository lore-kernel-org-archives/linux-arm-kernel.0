From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 28 Nov 2018 14:08:42 +0000
Subject: [PATCH 0/3] Convert SA1100 to use LEDs subsystem
Message-ID: <20181128140842.GH30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series, following on from the "SA11xx PCMCIA updates and
GPIOD conversion" series, converts SA11x0 to use the LEDs
subsystem and GPIO interfaces.

 arch/arm/mach-sa1100/Kconfig   |   2 +
 arch/arm/mach-sa1100/assabet.c | 143 ++++++++++++++++-------------------------
 arch/arm/mach-sa1100/cerf.c    |  11 +---
 3 files changed, 60 insertions(+), 96 deletions(-)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
