From: yixun.lan@amlogic.com (Yixun Lan)
Date: Thu, 16 Nov 2017 17:01:13 +0800
Subject: [PATCH v5 0/2] meson: saradc: drop the sana clock
Message-ID: <20171116090115.29915-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a rework for the patch [v4 4/4] of previous series,
which mean this will make the patch [1] obsolete.

Changes since v4:
 * separate DTS for ARM(32bit) vs ARM64
 * add ACK from Martin

[1] [PATCH v4 4/4] ARM64: dts: meson: drop "sana" clock from SAR ADC
http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005266.html

Xingyu Chen (2):
  ARM64: dts: meson: drop "sana" clock from SAR ADC
  ARM: dts: meson: drop "sana" clock from SAR ADC

 arch/arm/boot/dts/meson8.dtsi               | 5 ++---
 arch/arm/boot/dts/meson8b.dtsi              | 5 ++---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 3 +--
 4 files changed, 6 insertions(+), 10 deletions(-)

-- 
2.14.1
