From: plaes@plaes.org (Priit Laes)
Date: Tue,  3 May 2016 20:14:17 +0300
Subject: [PATCH 0/2] ARM: dts: sunxi: Add pll3 and pll7 clock to sun[47]i.dtsi
Message-ID: <1462295659-6945-1-git-send-email-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the pll3 and pll7 clocks in the DT that are used to drive the
display-related clocks.

Priit Laes (2):
  ARM: sun4i: dt: Add pll3 and pll7 clocks
  ARM: sun7i: dt: Add pll3 and pll7 clocks

 arch/arm/boot/dts/sun4i-a10.dtsi | 44 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi | 41 +++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

-- 
2.8.1
