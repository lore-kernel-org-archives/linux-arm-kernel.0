From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 23 Mar 2010 14:00:26 -0400 (EDT)
Subject: Git pull req: Kirkwood/Orion fixes for 2.6.34-rc2
Message-ID: <alpine.LFD.2.00.1003231355390.31128@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, please pull:

	git://git.marvell.com/orion for-rmk

This contains 2 small fixes:

Christian Lamparter (2):
      [ARM] Kirkwood: WPS button keycode mapping
      [ARM] Orion5x: replace KEY_WLAN with KEY_WPS_BUTTON

 arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c |    4 ++--
 arch/arm/mach-orion5x/wrt350n-v2-setup.c       |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)


Nicolas
