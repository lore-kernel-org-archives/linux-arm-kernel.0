From: nm@ti.com (Nishanth Menon)
Date: Wed, 8 Apr 2015 18:56:25 -0500
Subject: [PATCH 0/2] ARM: dts: am57xx-beagle-x15: Fixes for RTC
Message-ID: <1428537387-18776-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Couple of fixes for MCP79410 RTC on BeagleBoard-X15 platform. This is
not urgent enough for 4.0 material, but will be good to have it on one
of 4.1 rcs. tested on next-20150407:
http://pastebin.ubuntu.com/10777733/
(NOTE: I believe DRA7 rtc still needs reset driver to be done before it can be fully functional).

Grygorii Strashko (1):
  ARM: dts: am57xx-beagle-x15: Fix IRQ type for mcp7941x

Nishanth Menon (1):
  ARM: dts: am57xx-beagle-x15: Fix RTC aliases

 arch/arm/boot/dts/am57xx-beagle-x15.dts |    3 ++-
 arch/arm/boot/dts/dra7.dtsi             |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

Regards,
Nishanth Menon
-- 
1.7.9.5
