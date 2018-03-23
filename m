From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Fri, 23 Mar 2018 21:30:35 +0900
Subject: [PATCH 0/2] net: ethernet: ave: add UniPhier PXs3 support
Message-ID: <1521808237-3623-1-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ethernet controller support on UniPhier PXs3 SoC.

Kunihiko Hayashi (2):
  dt-bindings: net: ave: add PXs3 support
  net: ethernet: ave: add UniPhier PXs3 support

 Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt | 1 +
 drivers/net/ethernet/socionext/sni_ave.c                          | 8 ++++++++
 2 files changed, 9 insertions(+)

-- 
2.7.4
