From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 15 Apr 2016 19:30:45 +0900
Subject: [PATCH 0/2] arm64: dts: uniphier: UniPhier DT updates for Linux
 4.7-rc1
Message-ID: <1460716247-28049-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Masahiro Yamada (2):
  arm64: dts: uniphier: fix I2C nodes of PH1-LD20
  arm64: dts: uniphier: change release address of spin-table

 .../boot/dts/socionext/uniphier-ph1-ld20-ref.dts   |  1 -
 .../boot/dts/socionext/uniphier-ph1-ld20.dtsi      | 28 +++++++---------------
 2 files changed, 9 insertions(+), 20 deletions(-)

-- 
1.9.1
