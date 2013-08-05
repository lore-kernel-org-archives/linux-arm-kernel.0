From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon,  5 Aug 2013 22:39:24 +0200
Subject: [PATCHv2 0/2] clk: sunxi: Add clock support for the A10s
Message-ID: <1375735167-18031-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This small patchset adds support for the gates found in the Allwinner A10s SoC.
Since the gates are the only clock that differ from the other supported
Allwinner SoCs so far, the two patches are quite trivial.

Thanks,
Maxime

Changes from v1:
  - Added missing documentation

Maxime Ripard (2):
  clk: sunxi: Add A10s gates
  ARM: sun5i: dt: Use the A10s gates in the DTSI

 Documentation/devicetree/bindings/clock/sunxi.txt  |  3 +
 .../bindings/clock/sunxi/sun5i-a10s-gates.txt      | 75 ++++++++++++++++++++++
 arch/arm/boot/dts/sun5i-a10s.dtsi                  | 36 ++++-------
 drivers/clk/sunxi/clk-sunxi.c                      | 15 +++++
 4 files changed, 107 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/sunxi/sun5i-a10s-gates.txt

-- 
1.8.3.4
