From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 31 Jul 2015 18:11:38 +0800
Subject: [PATCH 0/3] ARM: dts: sun5i: hsg-h702: Enable USB OTG and LRADC keys
Message-ID: <1438337501-8773-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

This series enables USB OTG and the volume buttons on the side of
the HSG-H702 tablet.

The third patch is just for reference, as the axp209 usb power supply
driver hasn't been merged yet.


Regards
ChenYu


Chen-Yu Tsai (3):
  ARM: dts: sun5i: hsg-h702: Enable side volume buttons with LRADC
  ARM: dts: sun5i: hsg-h702: Enable USB OTG controller
  ARM: dts: sun5i: hsg-h702: Enable AXP209 USB power supply

 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts | 65 ++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

-- 
2.5.0
