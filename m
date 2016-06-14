From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 14 Jun 2016 12:01:40 +0900
Subject: [PATCH 0/3] arm64: dts: uniphier: UniPhier DTS updates (64bit) for
 v4.8-rc1
Message-ID: <1465873303-30754-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Masahiro Yamada (3):
  arm64: dts: uniphier: add SoC-Glue node to UniPhier 64bit SoCs
  arm64: dts: uniphier: change cpu-release-address
  arm64: dts: uniphier: add /memreserve/ for spin-table release address

 arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

-- 
1.9.1
