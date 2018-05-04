From: shawnguo@kernel.org (Shawn Guo)
Date: Fri,  4 May 2018 08:57:22 +0800
Subject: [PATCH 0/4] Fix avoid_unnecessary_addr_size DTC warning with 'clocks'
 node
Message-ID: <1525395446-1953-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series is to clean up avoid_unnecessary_addr_size DTC warning seen
with 'clocks' container node in i.MX dts files.

Shawn Guo (4):
  ARM: dts: imx: drop unnecessary #address-cells/#size-cells
  ARM: dts: imx1: move clk32 clock into soc dtsi
  ARM: dts: imx27: use lable to override osc26m clock setting
  ARM: dts: imx: drop 'clocks' container for board level clocks

 arch/arm/boot/dts/imx1-ads.dts               | 11 -----------
 arch/arm/boot/dts/imx1.dtsi                  |  8 ++++++++
 arch/arm/boot/dts/imx25.dtsi                 |  3 ---
 arch/arm/boot/dts/imx27-apf27.dts            | 13 +++----------
 arch/arm/boot/dts/imx27.dtsi                 |  5 +----
 arch/arm/boot/dts/imx28-tx28.dts             | 13 ++++---------
 arch/arm/boot/dts/imx50.dtsi                 |  3 ---
 arch/arm/boot/dts/imx51.dtsi                 |  3 ---
 arch/arm/boot/dts/imx53-tx53.dtsi            | 11 +++++------
 arch/arm/boot/dts/imx53.dtsi                 |  3 ---
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts | 15 ++++++---------
 arch/arm/boot/dts/imx6q-bx50v3.dtsi          | 11 ++++-------
 arch/arm/boot/dts/imx6qdl.dtsi               |  3 ---
 arch/arm/boot/dts/imx6sl.dtsi                |  3 ---
 14 files changed, 31 insertions(+), 74 deletions(-)

-- 
1.9.1
