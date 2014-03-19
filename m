From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Wed, 19 Mar 2014 15:19:29 -0300
Subject: [PATCH 0/4] sunxi clock fixes
Message-ID: <1395253173-30437-1-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is a small series of patches fixing a couple of bugs that are 
present on the sunxi clock driver. Mike, are there any chances we can
take these during the 3.15 merge window or -rc period?

Cheers,

Emilio

Emilio L?pez (4):
  clk: sunxi: fix A20 PLL4 calculation
  ARM: sun7i: fix PLL4 clock and add PLL8
  clk: sunxi: fix some calculations
  clk: sunxi: fix thinko in comment

 arch/arm/boot/dts/sun7i-a20.dtsi | 10 +++++++++-
 drivers/clk/sunxi/clk-sunxi.c    | 15 +++++++++++----
 2 files changed, 20 insertions(+), 5 deletions(-)

-- 
1.9.0
