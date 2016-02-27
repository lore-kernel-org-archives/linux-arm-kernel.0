From: codekipper@gmail.com (codekipper at gmail.com)
Date: Sat, 27 Feb 2016 17:18:24 +0100
Subject: [linux-sunxi][PATCH 0/5] ARM: sunxi: Add SPDIF playback support
Message-ID: <1456589909-2428-1-git-send-email-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Hi All,

now that the sun4i-spdif driver has made it into linux-next then this patch
series completes what is needed to have SPDIF working on both A10 and A20
devices.

Enjoy,
CK

Andrea Venturi (1):
  clk: sunxi: mod1 clock should modify it's parent

Marcus Cooper (4):
  ARM: dts :sunxi: Add SPDIF pins to A10 and A20
  ARM: dts: sunxi: Add the SPDIF to the A10 and A20
  ARM: dts: sun4i: Add SPDIF to the Mele A1000
  ARM: dts: sun7i: Add SPDIF to Itead Ibox

 arch/arm/boot/dts/sun4i-a10-a1000.dts      | 23 ++++++++++++++++
 arch/arm/boot/dts/sun4i-a10.dtsi           | 44 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20-itead-ibox.dts | 24 ++++++++++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi           | 44 ++++++++++++++++++++++++++++++
 drivers/clk/sunxi/clk-a10-mod1.c           |  2 +-
 5 files changed, 136 insertions(+), 1 deletion(-)

-- 
2.7.1
