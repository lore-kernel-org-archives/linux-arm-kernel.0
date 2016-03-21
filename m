From: codekipper@gmail.com (codekipper at gmail.com)
Date: Mon, 21 Mar 2016 21:00:58 +0100
Subject: [linux-sunxi][PATCH v3 0/8] ARM: sunxi: Add SPDIF playback support
Message-ID: <1458590466-12572-1-git-send-email-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Hi All,

now that the sun4i-spdif driver has made it into linux-next then this patch
series completes what is needed to have SPDIF working on both A10 and A20
devices.

Enjoy,
CK

---
Changes since v2:
- Split the patches up, added and removed some newlines, removed unused spdif
  pins

Changes since v1:
- Added defines to the dma properties and changed reg length to cover the entire
  spdif memory area.

Marcus Cooper (8):
  ARM: dts :sunxi: Add SPDIF TX pin to the A10
  ARM: dts :sun7i: Add SPDIF TX pin to the A20
  ARM: dts: sun4i: Add the SPDIF clk to the A10
  ARM: dts: sun7i: Add the SPDIF clk to the A20
  ARM: dts: sun4i: Add the SPDIF block to the A10
  ARM: dts: sun7i: Add the SPDIF block to the A20
  ARM: dts: sun4i: Add SPDIF to the Mele A1000
  ARM: dts: sun7i: Add SPDIF to the Itead Ibox

 arch/arm/boot/dts/sun4i-a10-a1000.dts      | 24 +++++++++++++++++++++++
 arch/arm/boot/dts/sun4i-a10.dtsi           | 31 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20-itead-ibox.dts | 24 +++++++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi           | 31 ++++++++++++++++++++++++++++++
 4 files changed, 110 insertions(+)

-- 
2.7.4
