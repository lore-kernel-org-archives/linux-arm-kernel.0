From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 26 Feb 2017 14:04:06 +0900
Subject: [PATCH 0/3] arm,
 arm64: dts: uniphier: remove skeleton.dtsi inclusion and fix warnings
Message-ID: <1488085449-28922-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  - The inclusion of skeleton.dtsi is deprecated.
    Specify #address-cells and #size-cells explicitly

  - If built with W=1, many warnings are displayed.  Fix them.


Masahiro Yamada (3):
  ARM: dts: uniphier: remove skeleton.dtsi inclusion
  ARM: dts: uniphier: fix no unit name warnings
  arm64: dts: uniphier: fix no unit name warnings

 arch/arm/boot/dts/uniphier-ld4-ref.dts              | 2 +-
 arch/arm/boot/dts/uniphier-ld4.dtsi                 | 4 ++--
 arch/arm/boot/dts/uniphier-ld6b-ref.dts             | 2 +-
 arch/arm/boot/dts/uniphier-pro4-ace.dts             | 2 +-
 arch/arm/boot/dts/uniphier-pro4-ref.dts             | 2 +-
 arch/arm/boot/dts/uniphier-pro4-sanji.dts           | 2 +-
 arch/arm/boot/dts/uniphier-pro4.dtsi                | 4 ++--
 arch/arm/boot/dts/uniphier-pro5.dtsi                | 4 ++--
 arch/arm/boot/dts/uniphier-pxs2-gentil.dts          | 2 +-
 arch/arm/boot/dts/uniphier-pxs2-vodka.dts           | 2 +-
 arch/arm/boot/dts/uniphier-pxs2.dtsi                | 4 ++--
 arch/arm/boot/dts/uniphier-sld3-ref.dts             | 2 +-
 arch/arm/boot/dts/uniphier-sld3.dtsi                | 4 ++--
 arch/arm/boot/dts/uniphier-sld8-ref.dts             | 2 +-
 arch/arm/boot/dts/uniphier-sld8.dtsi                | 4 ++--
 arch/arm/boot/dts/uniphier-support-card.dtsi        | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi    | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi    | 2 +-
 20 files changed, 26 insertions(+), 26 deletions(-)

-- 
2.7.4
