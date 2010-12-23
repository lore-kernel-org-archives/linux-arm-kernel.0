From: balbi@ti.com (Felipe Balbi)
Date: Thu, 23 Dec 2010 10:47:34 +0200
Subject: [GIT PULL] OMAP USB Changes for Merge Window
Message-ID: <20101223084734.GA3149@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

please queue the following two patches for Merge Window.

The following changes since commit b79540fcbbcf9b379c9197f63c5a883bbe3adfd4:

    Linux-omap rebuilt: Merged branches from Paul and Kevin and mux changes (2010-12-22 19:13:33 -0800)

are available in the git repository at:

    git://gitorious.org/usb/usb.git for-tony

Felipe Balbi (1):
        arm: omap: tusb6010: add name for MUSB IRQ

Srinath (1):
        arm: omap: craneboard: Add USB EHCI support

   arch/arm/mach-omap2/board-am3517crane.c |   48 +++++++++++++++++++++++++++++++
   arch/arm/mach-omap2/usb-tusb6010.c      |    1 +
   2 files changed, 49 insertions(+), 0 deletions(-)

-- 
balbi
