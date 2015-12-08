From: codekipper@gmail.com (codekipper at gmail.com)
Date: Tue,  8 Dec 2015 19:48:52 +0100
Subject: [linux-sunxi][PATCH 0/2] ARM: dts: sun4i: mk802 variant patches
Message-ID: <1449600534-5098-1-git-send-email-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

This patch series splits the mk802 dts into common include file which
can be shared with the mk802+ device. The only difference that I can
see between this and the original device is that it has an internal
microphone.

With that in mind we can either leave things as they are and enable
the capture to the original mk802 dts or apply this patch to distinguish
between the two devices.

CK

Marcus Cooper (2):
  ARM: dts: sun4i: Create common dtsi for mk802
  ARM: dts: sun4i: Add rikomagic mk802+ board

 arch/arm/boot/dts/Makefile                |   1 +
 arch/arm/boot/dts/sun4i-a10-mk802-1gb.dts |  50 ++++++++++++++
 arch/arm/boot/dts/sun4i-a10-mk802.dts     |  64 +-----------------
 arch/arm/boot/dts/sun4i-a10-mk802.dtsi    | 108 ++++++++++++++++++++++++++++++
 4 files changed, 160 insertions(+), 63 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun4i-a10-mk802-1gb.dts
 create mode 100644 arch/arm/boot/dts/sun4i-a10-mk802.dtsi

-- 
1.9.1
