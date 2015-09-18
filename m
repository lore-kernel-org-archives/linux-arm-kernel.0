From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 18 Sep 2015 21:47:36 +0800
Subject: [PATCH 0/3] arm64: dts: berlin4ct: add GPIO support
Message-ID: <1442584059-7319-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marvell berlin4ct SoC has 6 GPIO ports powered by snps,dw-apb-gpio. patch1
enables ARCH_REQUIRE_GPIOLIB for ARCH_BERLIN. patch2 add GPIO nodes in the
SoC dtsi. The last patch add board dts file for STB reference board.

Jisheng Zhang (3):
  arm64: berlin: enable ARCH_REQUIRE_GPIOLIB
  arm64: dts: berlin4ct: add GPIO nodes
  arm64: dts: add dts file for Marvell Berlin4CT STB board

 arch/arm64/Kconfig.platforms                  |   1 +
 arch/arm64/boot/dts/marvell/berlin4ct-stb.dts |  66 ++++++++++++++
 arch/arm64/boot/dts/marvell/berlin4ct.dtsi    | 120 ++++++++++++++++++++++++++
 3 files changed, 187 insertions(+)
 create mode 100644 arch/arm64/boot/dts/marvell/berlin4ct-stb.dts

-- 
2.5.1
