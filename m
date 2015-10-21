From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 21 Oct 2015 22:52:53 +0200
Subject: [PATCH 00/13] ARM: sunxi: Enable the audio codec
Message-ID: <1445460786-18280-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This serie enables the support for the audio codec in the DTSI and in
a bunch of boards it has been tested on so far.

Thanks!
Maxime

Emilio L?pez (2):
  ARM: sun7i: Add sunxi codec device node
  ARM: sun7i: dt: enable audio codec on Cubietruck

Marcus Cooper (2):
  ARM: sun4i: Add sunxi codec device node
  ARM: sun4i: Enable audio-codec on Mele A1000

Maxime Ripard (9):
  ARM: sun4i: Add audio PLL
  ARM: sun5i: Add audio PLL
  ARM: sun7i: Add audio PLL
  ARM: sun4i: Add audio codec clock
  ARM: sun5i: Add audio codec clock
  ARM: sun7i: Add audio codec clock
  ARM: sun5i: Add the Audio codec DT node
  ARM: sun7i: Enable cubieboard2 audio codec
  ARM: sun5i: chip: Enable the audio codec

 arch/arm/boot/dts/sun4i-a10-a1000.dts       |  4 ++++
 arch/arm/boot/dts/sun4i-a10.dtsi            | 31 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/sun5i-r8-chip.dts         |  4 ++++
 arch/arm/boot/dts/sun5i.dtsi                | 31 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts |  4 ++++
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts  |  4 ++++
 arch/arm/boot/dts/sun7i-a20.dtsi            | 31 +++++++++++++++++++++++++++++
 7 files changed, 109 insertions(+)

-- 
2.6.2
