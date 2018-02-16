From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 16 Feb 2018 11:55:32 +0100
Subject: [PATCH V3 0/2 RESEND] ARM: dts: bcm283x: Fix probing of bcm2835-i2s
Message-ID: <1518778534-3328-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This small series fixes the probing of bcm2835-i2s, which is broken
since 517e7a1537a ("ASoC: bcm2835: move to use the clock framework").

Changes in V3:
* split up patch into dt-binding and functional part

Changes in V2:
* add Fixes, Reviewed-by and Tested-by tags

Stefan Wahren (2):
  dt-bindings: bcm283x: Fix register ranges of bcm2835-i2s
  ARM: dts: bcm283x: Fix probing of bcm2835-i2s

 Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt   | 4 ++--
 Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt | 9 ++++-----
 arch/arm/boot/dts/bcm283x.dtsi                               | 4 ++--
 3 files changed, 8 insertions(+), 9 deletions(-)

-- 
2.7.4
