From: mporter@ti.com (Matt Porter)
Date: Thu,  9 Feb 2012 15:16:24 -0500
Subject: [PATCH 0/2] omap: fix omap2plus defaults for am35xx parts
Message-ID: <1328818586-7104-1-git-send-email-mporter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series enables all current am35xx boards and the on-chip Ethernet
driver in omap2plus_defconfig. It will help users of these boards to
have a working defconfig out of the box.

Matt Porter (2):
  omap: enable davinci_emac in omap2plus_defconfig for am35xx
  omap: build am3517crane board support by default

 arch/arm/configs/omap2plus_defconfig |    1 +
 arch/arm/mach-omap2/Kconfig          |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

-- 
1.7.5.4
