From: codekipper@gmail.com (codekipper at gmail.com)
Date: Mon, 29 Jan 2018 10:18:58 +0100
Subject: [linux-sunxi][PATCH v2 0/5] Add tested digital audio blocks to A64
Message-ID: <20180129091903.12319-1-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Hi All,

this patch series adds the digital audio blocks to the A64 SoC. No block
changes are necessary.

BR,
CK

---
v2 changes compared to v1 are:
- Added SoC specific compatiables
- moved spdif default pins to dtsi
- Added i2s2 block for HDMI as it has now been tested.
---
Marcus Cooper (5):
  arm64: allwinner: a64: Add the SPDIF block and pin
  arm64: allwinner: a64: Add SPDIF to the A64
  arm64: allwinner: a64: Add SPDIF to the Pine64
  arm64: allwinner: a64: Add DAI nodes
  arm64: allwinner: a64: Add DAI node for HDMI

 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |  5 ++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      | 81 ++++++++++++++++++++++
 2 files changed, 86 insertions(+)

-- 
2.16.1
