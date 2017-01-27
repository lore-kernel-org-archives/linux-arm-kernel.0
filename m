From: codekipper@gmail.com (codekipper at gmail.com)
Date: Fri, 27 Jan 2017 16:48:05 +0100
Subject: [linux-sunxi][PATCH 0/3] Enable SPDIF on the Beelink X2
Message-ID: <20170127154808.19229-1-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Hi All,

here is the patchset required to get SPDIF working on the Beelink X2
which is a H3 based STB.

BR,
CK

Marcus Cooper (3):
  ARM: dts: sun8i-h3: Add SPDIF TX pin to the H3
  ARM: dts: sun8i-h3: Add the SPDIF block to the H3
  ARM: dts: sun8i-h3: Add SPDIF to the Beelink X2

 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts | 24 ++++++++++++++++++++++++
 arch/arm/boot/dts/sun8i-h3.dtsi           | 18 ++++++++++++++++++
 2 files changed, 42 insertions(+)

-- 
2.11.0
