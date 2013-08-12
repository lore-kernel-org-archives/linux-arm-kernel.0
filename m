From: richard.genoud@gmail.com (Richard Genoud)
Date: Mon, 12 Aug 2013 14:30:58 +0200
Subject: [PATCH 0/4] Add sound in SAM9x5 DTS
Message-ID: <1376310662-20003-1-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the sam9x5-wm8731 machine driver has been merged, we have now to add
the device tree nodes...
And here they are !

(Based on next-20130812)
Tested on at91sam9g35-ek

[I didn't add the DT list, as far as there's no new binding, we don't
have to bother themi, right ?]

Richard Genoud (4):
  ARM: AT91: DTS: sam9x5: add SSC DMA parameters
  ARM: AT91: DTS: sam9x5ek: add WM8731 codec
  ARM: AT91: DTS: sam9x5ek: enable SSC
  ARM: AT91: DTS: sam9x5ek: add sound configuration

 arch/arm/boot/dts/at91sam9x5.dtsi   |    3 +++
 arch/arm/boot/dts/at91sam9x5ek.dtsi |   24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

-- 
1.7.10.4
