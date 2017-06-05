From: wens@csie.org (Chen-Yu Tsai)
Date: Mon,  5 Jun 2017 17:00:31 +0800
Subject: [PATCH v2 0/2] ARM/arm64: sunxi: convert CCU raw numbers to macros
Message-ID: <20170605090033.31663-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

This is a fixed version of my "convert CCU raw numbers to macros" series.
Please take these instead.

Changes since v1:

  - Fixed incorrect macro name for IR reset control phandle

  - Fixed header filename typo

These are some clean up patches for 4.12. They convert raw number
references for the CCU and R_CCU nodes, from when the CCU/R_CCU stuff
was first added, to the defined macros in the device tree header files.

These affect the A64 and H3/H5.

These are based on our sunxi/fixes-for-4.12 branch. Once these are merged,
I think it's time to send off pull requests for our fixes branches.

ChenYu

Chen-Yu Tsai (2):
  ARM: sunxi: h3-h5: Convert R_CCU raw numbers to macros
  arm64: allwinner: a64: Convert CCU raw number references to macros

 arch/arm/boot/dts/sunxi-h3-h5.dtsi            |  8 +++---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 35 ++++++++++++++-------------
 2 files changed, 23 insertions(+), 20 deletions(-)

-- 
2.11.0
