From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 12 Jun 2017 23:56:53 +0800
Subject: [PATCH v2 0/3] add support of hardware random generator on MediaTek
 MT7622
Message-ID: <cover.1497280813.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Changes since v1:
- update the bindings with the specific "mediatek,mt7622-rng"
  instead of the generic one as "mediatek,generic-rng"

The series add support of hardware RNG on MediaTek MT7622 and
, runtime PM support and add me as the maintainer for the existing
and following chipset.

Sean Wang (3):
  dt-bindings: rng: add MediaTek MT7622 Hardware Random Generator
    bindings
  hwrng: mtk - add runtime PM support
  MAINTAINERS: add entry for MediaTek Random Number Generator

 Documentation/devicetree/bindings/rng/mtk-rng.txt |  4 ++-
 MAINTAINERS                                       |  5 +++
 drivers/char/hw_random/mtk-rng.c                  | 42 +++++++++++++++++++++++
 3 files changed, 50 insertions(+), 1 deletion(-)

-- 
1.9.1
