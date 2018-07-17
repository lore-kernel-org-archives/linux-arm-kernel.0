From: ykaneko0929@gmail.com (Yoshihiro Kaneko)
Date: Wed, 18 Jul 2018 04:47:56 +0900
Subject: [PATCH/RFT 0/7] rsnd: add support for r8a77965
Message-ID: <1531856883-19645-1-git-send-email-ykaneko0929@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds sound support for r8a77965 (R-Car M3-N).
This series is based on the devel branch of Simon Horman's renesas tree.

Hiroyuki Yokoyama (1):
  ASoC: rsnd: Document R-Car M3-N support

Takeshi Kihara (6):
  arm64: dts: renesas: r8a77965: Add Audio-DMAC device nodes
  arm64: dts: renesas: r8a77965: Add Sound device node and SSI support
  arm64: dts: renesas: r8a77965: Add Sound SRC support
  arm64: dts: renesas: r8a77965: Add Sound DVC device nodes
  arm64: dts: renesas: r8a77965: Add Sound CTU support
  arm64: dts: renesas: r8a77965: Add Sound MIX support

 .../devicetree/bindings/sound/renesas,rsnd.txt     |   1 +
 arch/arm64/boot/dts/renesas/r8a77965.dtsi          | 245 ++++++++++++++++++++-
 2 files changed, 235 insertions(+), 11 deletions(-)

-- 
1.9.1
