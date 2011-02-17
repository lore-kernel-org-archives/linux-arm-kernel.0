From: balbi@ti.com (Felipe Balbi)
Date: Thu, 17 Feb 2011 14:40:59 +0200
Subject: [patch-v2.6.39 0/7] Patches for next merge window
Message-ID: <1297946466-9565-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

here are the patches for next merge window which I
have queued for you. A pull request is comming tomorrow.

All patches where boot tested on omap4430 pandaboard.

Anand Gadiyar (2):
  arm: omap4: usb: explicitly configure MUSB pads
  arm: omap4: 4430sdp: drop ehci support

Hema HK (5):
  OMAP2430: hwmod data: Add USBOTG
  OMAP3xxx: hwmod data: Add USBOTG
  AM35xx: hwmod data: Add USBOTG
  OMAP4430: hwmod data: Adding USBOTG
  OMAP2+: musb: hwmod adaptation for musb registration

 arch/arm/mach-omap2/board-4430sdp.c        |   19 ---
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   98 ++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  166 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   93 ++++++++++++++++
 arch/arm/mach-omap2/usb-musb.c             |  122 ++++++++++++++-------
 5 files changed, 440 insertions(+), 58 deletions(-)

-- 
1.7.4.rc2
