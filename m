From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri,  7 Feb 2014 22:20:38 +0100
Subject: [PATCH v2 0/2] misc: eeprom: sunxi: Change compatible pattern
Message-ID: <1391808040-29814-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is the second version of the A10 SID compatible changes.
The only difference with the v1 being that we're now droping the old
compatibles, instead of keeping them, since the DT maintainers said it was
fine.

Thanks,
Maxime

Maxime Ripard (2):
  misc: eeprom: sunxi: Change compatibles
  ARM: sunxi: dt: Convert to the new SID compatibles

 Documentation/devicetree/bindings/misc/allwinner,sunxi-sid.txt | 4 ++--
 arch/arm/boot/dts/sun4i-a10.dtsi                               | 2 +-
 arch/arm/boot/dts/sun5i-a10s.dtsi                              | 2 +-
 arch/arm/boot/dts/sun5i-a13.dtsi                               | 2 +-
 drivers/misc/eeprom/sunxi_sid.c                                | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

-- 
1.8.4.2
