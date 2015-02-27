From: andy.yan@rock-chips.com (Andy Yan)
Date: Fri, 27 Feb 2015 18:55:05 +0800
Subject: [PATCH 0/2] add dts for PopMetal board
Message-ID: <1425034505-25163-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


PopMetal is a rockchip rk3288 based board made by ChipSpark,
which has many interface such as VGA,HDMI,usb,ir,sdcad and lots of
sensors such as gyroscope(L3G4200D),accelerometer(mma8452),compass(AK8963C).

http://wiki.chipspark.com/en/index.php?title=PopMetal

This patch add basic support for it. More feather will be enabled later.


Andy Yan (2):
  dt-bindings: add root compatible property for PopMetal board
  ARM: dts: add rk3288 PopMetal board

 Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
 arch/arm/boot/dts/rk3288-popmetal.dts              | 396 +++++++++++++++++++++
 2 files changed, 400 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3288-popmetal.dts

-- 
1.9.1
