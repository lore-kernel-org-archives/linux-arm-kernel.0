From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon,  8 Sep 2014 11:19:15 +0200
Subject: [PATCH v2 0/5] Change vendor prefix for Intersil Corporation
Message-ID: <1410167960-554-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

currently there is a wild mixture of isl, isil, and intersil
compatibles in the kernel. I figure at this point it is still
possible to change this to use "isil" everywhere without too
much pain, but it might be preferred to keep the already
documented "isl" prefix, even though it doesn't follow the
convention to use the NASDAQ symbol where available.

This is an updated version of the RFC I've sent previously:
https://www.mail-archive.com/devicetree at vger.kernel.org/msg38505.html

Changes since RFC:
 - Drop powerpc/85xx patch, that device tree set in stone.
 - Added commit summaries where referencing commit ids
 - Added deprecated names to the documentation

regards
Philipp

Philipp Zabel (5):
  of: Change vendor prefix for Intersil Corporation to isil
  Documentation: Add isl1208 and isl12022 to trivial-devices list
  ARM: mvebu: Change vendor prefix for Intersil Corporation to isil
  rtc: rtc-isl12022: Change vendor prefix for Intersil Corporation to
    isil
  rtc: rtc-isl12057: Change vendor prefix for Intersil Corporation to
    isil

 Documentation/devicetree/bindings/i2c/trivial-devices.txt | 6 +++++-
 Documentation/devicetree/bindings/vendor-prefixes.txt     | 4 +++-
 arch/arm/boot/dts/armada-370-netgear-rn102.dts            | 2 +-
 arch/arm/boot/dts/armada-370-netgear-rn104.dts            | 2 +-
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts            | 2 +-
 drivers/rtc/rtc-isl12022.c                                | 3 ++-
 drivers/rtc/rtc-isl12057.c                                | 3 ++-
 7 files changed, 15 insertions(+), 7 deletions(-)

-- 
2.1.0.rc1
