From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  6 Feb 2014 09:55:56 +0100
Subject: [PATCH v2 0/2] clk: sunxi: Change compatibles pattern
Message-ID: <1391676958-13883-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is the second version of the clock compatible changes.
The only difference with the v1 being that we're now droping the old
compatibles, instead of keeping them, since the DT maintainers said it was
fine.

Thanks,
Maxime

Maxime Ripard (2):
  clk: sunxi: Add new clock compatibles
  ARM: sunxi: dt: Convert to the new clock compatibles

 Documentation/devicetree/bindings/clock/sunxi.txt | 36 +++++++-------
 arch/arm/boot/dts/sun4i-a10.dtsi                  | 60 +++++++++++------------
 arch/arm/boot/dts/sun5i-a10s.dtsi                 | 48 +++++++++---------
 arch/arm/boot/dts/sun5i-a13.dtsi                  | 48 +++++++++---------
 arch/arm/boot/dts/sun6i-a31.dtsi                  | 10 ++--
 arch/arm/boot/dts/sun7i-a20.dtsi                  | 54 ++++++++++----------
 drivers/clk/sunxi/clk-sunxi.c                     | 30 ++++++------
 7 files changed, 143 insertions(+), 143 deletions(-)

-- 
1.8.4.2
