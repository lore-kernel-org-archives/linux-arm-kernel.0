From: oliver+list@schinagl.nl (oliver+list at schinagl.nl)
Date: Sat,  5 Oct 2013 17:17:26 +0200
Subject: [PATCH] ARM: sunxi: dts: preliminary cubietruck support
Message-ID: <1380986247-29112-1-git-send-email-oliver+list@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Oliver Schinagl <oliver+list@schinagl.nl>

A new cubieboard has been introduced, the cubietruck. I did try to also add emac support, but that didn't work well with the included RTL8211E Gbit PHY so I ommited that for now (it doesn't work with u-boot either).

I tested the uart0 port and the LEDS which all seemed to work as expected.

Oliver Schinagl (1):
  ARM: sunxi: dts: Add support for the cubieboard3, the CubieTruck

 arch/arm/boot/dts/Makefile                 |  1 +
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 60 ++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-cubietruck.dts

-- 
1.8.1.5
