From: joonas.kylmala@iki.fi (=?UTF-8?q?Joonas=20Kylm=C3=A4l=C3=A4?=)
Date: Mon, 12 Feb 2018 18:29:44 +0200
Subject: [PATCH 0/1] ARM: dts: sun8i: h2-plus: remove unnecessary mmc1_pins
 node
Message-ID: <20180212162945.22152-1-joonas.kylmala@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

I made now the patch removing the unnecessary mmc1_pins node as discussed in
the email thread "ARM: dts: sunxi: h3-h5: rename mmc0_pins_a and mmc1_pins_a".

Joonas

Joonas Kylm?l? (1):
  ARM: dts: sun8i: h2-plus: remove unnecessary mmc1_pins node

 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts | 4 ----
 1 file changed, 4 deletions(-)

-- 
2.11.0
