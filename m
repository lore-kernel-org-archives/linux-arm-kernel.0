From: embed3d@gmail.com (Philipp Rossak)
Date: Fri, 15 Dec 2017 23:38:59 +0100
Subject: [PATCH 0/2] Ethernet for the Nanopi M1 & M1 plus
Message-ID: <20171215223901.14500-1-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first patch of this patch series, fixes a missing alias 
on the nanopi m1 plus. The second patch enables the dwmac-sun8i 
ethernet driver on the Nanopi M1.

Philipp Rossak (2):
  ARM: dts: sun8i: h3: nanopi-m1-plus: fix missing ethernet 0 in aliases
  ARM: dts: sun8i: h3: Enable dwmac-sun8i on the Nanopi M1

 arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts |  1 +
 arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts      | 11 +++++++++++
 2 files changed, 12 insertions(+)

-- 
2.11.0
