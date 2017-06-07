From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Wed,  7 Jun 2017 19:33:43 +0200
Subject: [PATCH v2 0/2] ARM: sunxi: Enable dwmac-sun8i on more boards
Message-ID: <20170607173345.22462-1-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

Since the first 3 patch of v1 was applied, it remains this two patchs for
enabling dwmac-sun8i on A83T

Changes since v1:
- Ordered compatible of syscon
- Renamed pins to emac-rgmii-pins

Corentin Labbe (2):
  ARM: sun8i: a83t: Add dt node for the syscon control module
  ARM: sun8i: a83t: add dwmac-sun8i ethernet driver

 arch/arm/boot/dts/sun8i-a83t.dtsi | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

-- 
2.13.0
