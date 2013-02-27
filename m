From: ruslan.bilovol@ti.com (Ruslan Bilovol)
Date: Wed, 27 Feb 2013 13:43:41 +0200
Subject: [PATCH RESEND 0/1] ARM: DTS: OMAP4: Add OMAP4 Blaze Tablet support
Message-ID: <1361965422-28057-1-git-send-email-ruslan.bilovol@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch is a second attempt to add basic support of OMAP4 Blaze Tablet
software development platform - in this case using only Device Tree.

Additional information about this platform can be found here:
http://www.svtronics.com/omap?product_id=15

Ruslan Bilovol (1):
  ARM: DTS: OMAP4: Add OMAP4 Blaze Tablet support

 arch/arm/boot/dts/Makefile              |    1 +
 arch/arm/boot/dts/omap4-blazetablet.dts |  390 +++++++++++++++++++++++++++++++
 2 files changed, 391 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap4-blazetablet.dts

-- 
1.7.9.5
