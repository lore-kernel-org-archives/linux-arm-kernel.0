From: codekipper@gmail.com (codekipper at gmail.com)
Date: Wed, 24 Jan 2018 11:39:38 +0100
Subject: [linux-sunxi][PATCH 0/5] Add tested digital audio blocks to A64
Message-ID: <20180124103943.2062-1-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Hi All,

this patch series adds the digital audio blocks to the A64 SoC. No block
changes are necessary.

BR,
CK

Marcus Cooper (5):
  arm64: allwinner: a64: Add the SPDIF block
  arm64: allwinner: a64: Add SPDIF TX pin to the A64
  arm64: allwinner: a64: Add SPDIF to the A64
  arm64: allwinner: a64: Add SPDIF to the Pine64
  arm64: allwinner: a64: Add DAI nodes

 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |  7 +++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      | 63 ++++++++++++++++++++++
 2 files changed, 70 insertions(+)

-- 
2.16.0
