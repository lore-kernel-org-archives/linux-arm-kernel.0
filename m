From: eddie.huang@mediatek.com (Eddie Huang)
Date: Mon, 1 Jun 2015 14:29:11 +0800
Subject: [PATCH 0/2] arm64: dts: Mediatek: MT8173 updtes 
Message-ID: <1433140153-22436-1-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add MT8173 watchdog and I2C device nodes. Both device nodes 
are based on 4.1-rc1, but I2C need two extra CCF patches from Sascha [1][2].

[1] clk: Add common clock support for Mediatek MT8135 and MT8173
    http://lists.infradead.org/pipermail/linux-arm-kernel/2015-April/338763.html
[2] ARM64: dts: mt8173: Add clock controller device nodes
    http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/344753.html

Eddie Huang (2):
  arm64: dts: mt8173: Add watchdog device node
  arm64: dts: mt8173: Add I2C device node

 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 125 +++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

-- 
1.8.1.1.dirty
