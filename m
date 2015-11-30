From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 30 Nov 2015 11:41:38 +0100
Subject: [PATCH) soc: mediatek: scpsys: Add regulator support to power domain
 driver
Message-ID: <1448880100-23396-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some power domains on the MT8173 are supplied by controllable external
regulators that must be handled properly. This series adds support for
them.

Sascha

----------------------------------------------------------------
Sascha Hauer (2):
      dt-bindings: soc: Add supplies for Mediatek SCPSYS unit
      soc: mediatek: SCPSYS: Add regulator support

 .../devicetree/bindings/soc/mediatek/scpsys.txt    | 12 ++++++++++
 drivers/soc/mediatek/mtk-scpsys.c                  | 27 ++++++++++++++++++++++
 2 files changed, 39 insertions(+)
