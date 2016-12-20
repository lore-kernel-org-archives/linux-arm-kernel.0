From: codekipper@gmail.com (codekipper at gmail.com)
Date: Tue, 20 Dec 2016 11:40:35 +0100
Subject: [linux-sunxi][PATCH 0/3] Enable SPDIF on the Mele I7
Message-ID: <20161220104038.22532-1-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Hi All,
here is the patch set required to enable SPDIF on the Mele I7 which is
a A31 based TV-box. To get this working a fix has to be applied to the
clock driver and this will be pushed seperately.

For now the dtsi changes can be applied and when the clk change is
merged then we can finialise this push by applying the I7 patch.
BR,
CK

Marcus Cooper (3):
  ARM: dts: sun6i: Add SPDIF TX pin to the A31
  ARM: dts: sun6i: Add the SPDIF block to the A31
  ARM: dts: sun6i: Add SPDIF to the Mele I7

 arch/arm/boot/dts/sun6i-a31-i7.dts | 24 ++++++++++++++++++++++++
 arch/arm/boot/dts/sun6i-a31.dtsi   | 19 +++++++++++++++++++
 2 files changed, 43 insertions(+)

-- 
2.11.0
