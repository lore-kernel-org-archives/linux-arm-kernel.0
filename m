From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 20 Nov 2015 17:46:59 +0800
Subject: [PATCH 0/2] Add I2C support for Marvell Berlin BG4CT
Message-ID: <1448012821-7413-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first patch adds i2c nodes in the soc's dtsi, the second patch
enables all i2c nodes for BG4CT STB board.

NOTE: this series depends on the missed-in-v4.4rc1 patches:

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/378634.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/378635.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/378638.html

Jisheng Zhang (2):
  arm64: dts: berlin4ct: add I2C nodes for BG4CT
  arm64: dts: berlin4ct: enable all i2c nodes for the STB board

 arch/arm64/boot/dts/marvell/berlin4ct-stb.dts | 50 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/marvell/berlin4ct.dtsi    | 52 +++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)

-- 
2.6.2
