From: hayashibara.keiji@socionext.com (Keiji Hayashibara)
Date: Fri, 26 Oct 2018 14:58:43 +0900
Subject: [PATCH v2 0/2] spi: fix incorrect property items
Message-ID: <1540533525-1816-1-git-send-email-hayashibara.keiji@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series fixes incorrect property because it was different
from the actual.

The commit 71b8dfc691a3 ("spi: uniphier: re-add addressing properties")
is the updated patch, therefore, it must be applied after
the commit 7662d1dc17d4 ("spi: uniphier: fix incorrect property items").

Changes since v1:
- Add commit 71b8dfc691a3 ("spi: uniphier: re-add addressing properties")
  The addressing properties of #address-cells and #size-cells
  are back again.

Keiji Hayashibara (2):
  spi: uniphier: fix incorrect property items
  spi: uniphier: re-add addressing properties

 Documentation/devicetree/bindings/spi/spi-uniphier.txt | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

-- 
2.7.4
