From: uri.mashiach@compulab.co.il (Uri Mashiach)
Date: Wed, 30 Dec 2015 13:41:32 +0200
Subject: [PATCH 0/3] ARM: dts: cm-t335: add peripherals - part 2
Message-ID: <1451475695-26921-1-git-send-email-uri.mashiach@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the following peripherals:
- CAN BUS
- Touchscreen
- Audio

Uri Mashiach (3):
  ARM: dts: cm-t335: Add support for CAN bus
  ARM: dts: cm-t335: add touchscreen support
  ARM: dts: cm-t335: add audio support

 arch/arm/boot/dts/am335x-cm-t335.dts | 116 +++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

-- 
2.5.0
