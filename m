From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Fri, 30 Mar 2018 12:51:18 +0900
Subject: [PATCH 0/2] add thermal monitor support for UniPhier PXs3 SoC
Message-ID: <1522381880-18892-1-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for thermal monitor implemented on UniPhier PXs3 SoC.

Kunihiko Hayashi (2):
  dt-bindings: thermal: uniphier: add a compatible string for PXs3
  thermal: uniphier: add UniPhier PXs3 support

 Documentation/devicetree/bindings/thermal/uniphier-thermal.txt | 1 +
 drivers/thermal/uniphier_thermal.c                             | 4 ++++
 2 files changed, 5 insertions(+)

-- 
2.7.4
