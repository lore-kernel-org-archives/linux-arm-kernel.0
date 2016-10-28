From: woogyom.kim@gmail.com (Milo Kim)
Date: Fri, 28 Oct 2016 15:59:00 +0900
Subject: [PATCH v2 0/3] ARM: dts: sun8i: Support NanoPi SBCs
Message-ID: <20161028065903.23298-1-woogyom.kim@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NanoPi M1 and NEO have common features, so duplicate properties can be 
moved into new dtsi file.

v2:
  Add James's copyrights in NanoPi common dtsi file 

Milo Kim (3):
  ARM: dts: sun8i: Add common dtsi file for NanoPi SBCs
  ARM: dts: sun8i: Use the common file in NanoPi NEO SBC
  ARM: dts: sun8i: Add dts file for NanoPi M1 SBC

 arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts  |  64 +++++++++++++
 arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts |  79 +---------------
 arch/arm/boot/dts/sun8i-h3-nanopi.dtsi    | 144 ++++++++++++++++++++++++++++++
 3 files changed, 209 insertions(+), 78 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h3-nanopi.dtsi

-- 
2.9.3
