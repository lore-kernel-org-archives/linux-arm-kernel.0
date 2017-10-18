From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 18 Oct 2017 13:24:31 +0900
Subject: [PATCH 0/6] ARM: dts: uniphier: add GPIO nodes and related properties
Message-ID: <1508300677-23190-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Masahiro Yamada (6):
  ARM: dts: uniphier: add GPIO controller nodes
  arm64: dts: uniphier: add GPIO controller nodes
  ARM: dts: uniphier: route on-board device IRQ to GPIO controller
  arm64: dts: uniphier: route on-board device IRQ to GPIO controller
  ARM: dts: uniphier: add GPIO hog definition
  arm64: dts: uniphier: add GPIO hog definition

 arch/arm/boot/dts/uniphier-ld4-ref.dts             | 10 ++++++++-
 arch/arm/boot/dts/uniphier-ld4.dtsi                | 14 ++++++++++++
 arch/arm/boot/dts/uniphier-ld6b-ref.dts            | 10 ++++++++-
 arch/arm/boot/dts/uniphier-pro4-ref.dts            | 10 ++++++++-
 arch/arm/boot/dts/uniphier-pro4.dtsi               | 14 ++++++++++++
 arch/arm/boot/dts/uniphier-pro5.dtsi               | 14 ++++++++++++
 arch/arm/boot/dts/uniphier-pxs2.dtsi               | 17 +++++++++++++++
 arch/arm/boot/dts/uniphier-sld8-ref.dts            | 10 ++++++++-
 arch/arm/boot/dts/uniphier-sld8.dtsi               | 18 ++++++++++++++++
 arch/arm/boot/dts/uniphier-support-card.dtsi       |  1 +
 .../arm64/boot/dts/socionext/uniphier-ld11-ref.dts | 11 +++++++++-
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi   | 25 ++++++++++++++++++++++
 .../arm64/boot/dts/socionext/uniphier-ld20-ref.dts | 11 +++++++++-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   | 19 ++++++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi   | 19 ++++++++++++++++
 15 files changed, 197 insertions(+), 6 deletions(-)

-- 
2.7.4
