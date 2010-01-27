From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 26 Jan 2010 23:02:48 -0500 (EST)
Subject: Git pull request: Orion/Kirkwood fixes for 2.6.33-rc
Message-ID: <alpine.LFD.2.00.1001262253170.1681@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, please could you pull the following:

	git://git.marvell.com/orion for-rmk

This contains the following fixes:

Dirk Teurlings (1):
      [ARM] Orion5x: add GPIO LED and buttons for wrt350n v2

Erik Benada (1):
      [ARM] orion5x: D-link DNS-323 rev. B1 power-off

Lennert Buytenhek (1):
      [ARM] Orion: fix PCIe inbound window programming when RAM size is not a power of two

Saeed Bishara (1):
      [ARM] Kirkwood: drive USB VBUS pin on rd88f6192-nas high on boot

 arch/arm/mach-kirkwood/rd88f6192-nas-setup.c |    6 ++
 arch/arm/mach-orion5x/dns323-setup.c         |   33 +++++++--
 arch/arm/mach-orion5x/wrt350n-v2-setup.c     |   79 ++++++++++++++++++++
 arch/arm/plat-orion/pcie.c                   |    6 ++
 4 files changed, 118 insertions(+), 6 deletions(-)


Nicolas
