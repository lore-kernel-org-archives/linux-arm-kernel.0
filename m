From: woogyom.kim@gmail.com (Milo Kim)
Date: Thu, 20 Oct 2016 17:06:58 +0900
Subject: [PATCH 0/3] ARM: dts: sun8i: Support NanoPi SBCs
Message-ID: <20161020080701.15993-1-woogyom.kim@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NanoPi M1 and NEO have common features, so duplicate properties can be 
moved into new dtsi file.

Milo Kim (3):
  ARM: dts: sun8i: Add common dtsi file for NanoPi SBCs
  ARM: dts: sun8i: Use the common file in NanoPi NEO SBC
  ARM: dts: sun8i: Add dts file for NanoPi M1 SBC

 arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts  |  64 +++++++++++++
 arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts |  79 +----------------
 arch/arm/boot/dts/sun8i-h3-nanopi.dtsi    | 143 ++++++++++++++++++++++++++++++
 3 files changed, 208 insertions(+), 78 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h3-nanopi.dtsi

-- 
2.9.3
