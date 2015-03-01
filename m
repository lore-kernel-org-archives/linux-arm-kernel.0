From: andy.yan@rock-chips.com (Andy Yan)
Date: Sun,  1 Mar 2015 17:25:14 +0800
Subject: [PATCH v2 0/2] add dts for PopMetal board
Message-ID: <1425201914-4695-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


PopMetal is a rockchip rk3288 based board made by ChipSpark,
which has many interface such as VGA,HDMI,usb,ir,sdcad and lots of
sensors such as gyroscope(L3G4200D),accelerometer(mma8452),compass(AK8963C).

http://wiki.chipspark.com/en/index.php?title=PopMetal

This patch add basic support for it, which can boot the board
into a shell with linux boot logo on hdmi, sdcard and many
sensors enabled. More feather will be enabled later.

Changes in v2:
- change "PopMetal PopMetal-RK3288 board" to "ChipSPARK PopMetal-RK3288 board"
- use GPL + X11 dual license, adviced by Heiko
- indent pwrbtn
- move node "ak8963" before "buttons"

Andy Yan (2):
  dt-bindings: add root compatible property for PopMetal board
  ARM: dts: add rk3288 PopMetal board

 Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
 arch/arm/boot/dts/rk3288-popmetal.dts              | 447 +++++++++++++++++++++
 2 files changed, 451 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3288-popmetal.dts

-- 
1.9.1
