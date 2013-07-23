From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 24 Jul 2013 00:28:22 +0200
Subject: [PATCH 0/2] clk: sunxi: Add clock support for the A10s
Message-ID: <1374618504-19391-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This small patchset adds support for the gates found in the Allwinner A10s SoC.
Since the gates are the only clock that differ from the other supported
Allwinner SoCs so far, the two patches are quite trivial.

Thanks,
Maxime

Maxime Ripard (2):
  clk: sunxi: Add A10s gates
  ARM: sun5i: dt: Use the A10s gates in the DTSI

 arch/arm/boot/dts/sun5i-a10s.dtsi | 36 ++++++++++++++----------------------
 drivers/clk/sunxi/clk-sunxi.c     | 15 +++++++++++++++
 2 files changed, 29 insertions(+), 22 deletions(-)

-- 
1.8.3.2
