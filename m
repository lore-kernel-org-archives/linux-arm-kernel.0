From: rogerq@ti.com (Roger Quadros)
Date: Mon, 7 Oct 2013 16:28:12 +0300
Subject: [PATCH 0/1] Possibly fix USB OTG on GTA04 and N900
Message-ID: <1381152493-28055-1-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

USB OTG on these boards might be broken on Greg's usb-next branch [1]
after the Generic PHY framework and associated patches were merged.

This is a probable fix but I'm not able to test these boards. Please
give it a try and your Ack if it works. Thanks.

[1] - git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git

cheers,
-roger

Roger Quadros (1):
  ARM: dts: omap3:  Adapt USB OTG to generic PHY framework

 arch/arm/boot/dts/omap3-gta04.dts |    2 ++
 arch/arm/boot/dts/omap3-n900.dts  |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

-- 
1.7.4.1
