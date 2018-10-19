From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 19 Oct 2018 19:30:16 +0900
Subject: [PATCH v3 0/2] dt-bindings: uniphier: two trivial DT bindings patches
Message-ID: <1539945019-24950-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Arnd, Olof,

I know it is very late in this development cycle.

If possible, could you directly apply these two patches
to your ARM-SoC, aiming for the upcoming v4.20-rc1 MW?

If not, I can wait for v4.21-rc1.

Thanks,
Masahiro


Changes in v3:
  - Capitalize 'Board' consistently
  - Add Rob's Reviewed-by

Changes in v2:
  Changes suggested by Rob.
  - Move the file to
    Documentation/devicetree/bindings/arm/socionext/uniphier.txt
  - Group boards by each SoC
  Previous post:
  v1: https://patchwork.ozlabs.org/patch/842010/
  - New patch

Masahiro Yamada (2):
  dt-bindings: uniphier: add bindings for UniPhier SoC family
  dt-bindings: uniphier: move cache-uniphier.txt to vendor directory

 .../arm/{uniphier => socionext}/cache-uniphier.txt |  0
 .../devicetree/bindings/arm/socionext/uniphier.txt | 47 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 3 files changed, 48 insertions(+)
 rename Documentation/devicetree/bindings/arm/{uniphier => socionext}/cache-uniphier.txt (100%)
 create mode 100644 Documentation/devicetree/bindings/arm/socionext/uniphier.txt

-- 
2.7.4
