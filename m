From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Mon, 1 Sep 2014 12:29:34 +0800
Subject: [PATCHv1 0/7] simple-card: simplify the code.
Message-ID: <1409545781-20530-1-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Change in v1:
- Add simple-card dts node patches.
- Fix format parsing bug from Jean-Francois's comment.
- Rebase to Kuninori-san's newest changes in next branch.


Xiubo Li (7):
  ASoC: simple-card: Merge single and muti DAI link code.
  ASoC: simple-card: Adjust the comments of simple card.
  ASoC: dts: vf610-twr: To support simple card newest style.
  ASoC: dts: kirkwood-t5325: To support simple card newest style.
  ASoC: dts: r8a7740-armadillo800eva-reference: To support simple card
    newest style.
  ASoC: dts: sh73a0-kzm9g-reference: To support simple card newest
    style.
  ASoC: dts: kirkwood-openrd-client: To support simple card newest
    style.

 .../devicetree/bindings/sound/simple-card.txt      | 101 ++++++------
 arch/arm/boot/dts/kirkwood-openrd-client.dts       |  15 +-
 arch/arm/boot/dts/kirkwood-t5325.dts               |  15 +-
 .../boot/dts/r8a7740-armadillo800eva-reference.dts |  21 +--
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts       |  18 ++-
 arch/arm/boot/dts/vf610-twr.dts                    |  17 +-
 sound/soc/generic/simple-card.c                    | 176 ++++++++-------------
 7 files changed, 160 insertions(+), 203 deletions(-)

-- 
1.8.4
