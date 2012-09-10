From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Mon, 10 Sep 2012 15:16:35 +0200
Subject: [PATCH 0/1] ARM: dts: OMAP3: Add gpio-twl4030 properties for Overo
Message-ID: <1347282996-31190-1-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch adds the support for the blue LED connected to the LEDB
pin of the TWL4030 on the Gumstix Overo when booting from the device
tree.

Build on top of Benoit's for_3.7/dts tree.

Regards,
Florian


Florian Vaussard (1):
  ARM: dts: OMAP3: Add gpio-twl4030 properties for Overo

 arch/arm/boot/dts/omap3-overo.dtsi |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

-- 
1.7.5.4
