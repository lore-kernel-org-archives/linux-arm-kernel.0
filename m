From: hao5781286@gmail.com (Hao Zhang)
Date: Wed, 21 Nov 2018 23:43:01 +0800
Subject: [PATCH v1 0/2] Initial Allwinner T3 support.
Message-ID: <20181121154301.GA4053@arx-s1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initial Allwinner T3 support.

Allwinner T3 (sun8i) SoC features a Quad-Core Cortex-A7 ARM CPU, and a
Mali400 MP2 GPU from ARM. It is a not-pin-compatible quad core sucessor
of the A20). It's also known as the Allwinner R40.

Hao Zhang (2):
  ARM: dts: sun8i: Add board dts file for t3-cqa3t-bv3.
  Documentation: ARM: sunxi: Add Allwinner SoC T3.

 Documentation/devicetree/bindings/arm/sunxi.txt |   3 +-
 arch/arm/boot/dts/Makefile                      |   1 +
 arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts        | 226 ++++++++++++++++++++++++
 3 files changed, 229 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts

-- 
2.7.4
