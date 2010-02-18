From: maz@misterjones.org (Marc Zyngier)
Date: Thu, 18 Feb 2010 20:23:47 +0000
Subject: [PATCH 0/5] Zeus fixes for 2.6.34
Message-ID: <20100218202347.1a902b3e@taxman.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric,

Here's the current state of my tree for the Zeus board.
Please consider queuing these patches for 2.6.34.

Thanks,

	M.

Amit Walambe (2):
  Correct the USB host initialisation flags of Arcom/Eurotech Zeus SBC.
  Add Eurotech as the manufacturer of the Zeus board

Marc Zyngier (3):
  pxa/zeus: Allow usage of 8250-compatible UART in uncompress
  watchdog: add support for onboard max6369 to Arcom Zeus
  pxa/zeus: Add support for mcp2515 CAN bus

 arch/arm/mach-pxa/include/mach/uncompress.h |   20 +++++--
 arch/arm/mach-pxa/include/mach/zeus.h       |    3 +-
 arch/arm/mach-pxa/zeus.c                    |   81 ++++++++++++++++++++++-----
 3 files changed, 84 insertions(+), 20 deletions(-)

-- 
I'm the slime oozin' out from your TV set...
