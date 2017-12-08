From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  8 Dec 2017 15:31:55 +0800
Subject: [PATCH 0/2] ARM: sun8i: a83t: Enable EMAC Ethernet
Message-ID: <20171208073157.14599-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is my spin on enabling Ethernet on the A83T. It consists of
Corentin's dtsi patch plus my board level patch. There's nothing
really special about them.

ChenYu

Chen-Yu Tsai (1):
  ARM: dts: sun8i: a83t: Enable Ethernet on two boards

Corentin LABBE (1):
  ARM: dts: sun8i: a83t: add dwmac-sun8i device node

 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts     | 19 ++++++++++++++
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts | 17 ++++++++++++
 arch/arm/boot/dts/sun8i-a83t.dtsi                | 33 ++++++++++++++++++++++++
 3 files changed, 69 insertions(+)

-- 
2.15.0
