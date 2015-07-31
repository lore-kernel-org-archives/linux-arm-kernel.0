From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 31 Jul 2015 22:40:57 +0800
Subject: [PATCH v2 0/2] ARM: dts: sun5i: hsg-h702: Enable USB OTG and LRADC
 keys
Message-ID: <1438353659-3360-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

This series enables USB OTG and the volume buttons on the side of
the HSG-H702 tablet.

v2 uses a reference for usb0_vbus_pin_a, instead of full path.
The third patch is also dropped to avoid confusion.


Regards
ChenYu


Chen-Yu Tsai (2):
  ARM: dts: sun5i: hsg-h702: Enable side volume buttons with LRADC
  ARM: dts: sun5i: hsg-h702: Enable USB OTG controller

 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts | 58 ++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

-- 
2.5.0
