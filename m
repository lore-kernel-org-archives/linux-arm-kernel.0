From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Mon, 17 Sep 2018 16:00:15 +0800
Subject: [PATCH v2 0/3] arm64: dts: add Synaptics AS370 SoC support
Message-ID: <20180917160015.05a1fc5b@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial dtsi file for Synaptics AS370 SoC.

patch1 moves berlin binding to syna.txt.
patch2 add dt-binding for the AS370 SoC.
patch3 add the initial dtsi file for the SoC.

since v1:
 - add Rob's ACK to patch1
 - add note about the transition from Marvell berlin to Synaptics SoC
 - remove aliases
 - uart at 0c00 => serial at c00

Jisheng Zhang (3):
  dt-bindings: arm: move berlin binding documentation to syna.txt
  dt-bindings: arm: syna: add support for the AS370 SoC
  arm64: dts: synaptics: add dtsi file for Synaptics AS370 SoC

 .../{marvell/marvell,berlin.txt => syna.txt}  |  11 +-
 arch/arm64/boot/dts/synaptics/as370.dtsi      | 173 ++++++++++++++++++
 2 files changed, 183 insertions(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/arm/{marvell/marvell,berlin.txt => syna.txt} (89%)
 create mode 100644 arch/arm64/boot/dts/synaptics/as370.dtsi

-- 
2.19.0
