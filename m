From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Tue, 24 Apr 2018 13:46:59 +0900
Subject: [PATCH 0/4] add additional required properties for UniPhier ethernet
 nodes
Message-ID: <1524545223-5893-1-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add required clocks and their names, resets and their names, and system
controller properties to fix the activation issues for the ethernet
controllers implemented on some UniPhier SoCs.

Kunihiko Hayashi (4):
  ARM: dts: uniphier: add required clocks and resets to Pro4 ethernet
    node
  arm64: dts: uniphier: add clock-names and reset-names to ethernet node
  ARM: dts: uniphier: add syscon-phy-mode property to each ethernet node
  arm64: dts: uniphier: add syscon-phy-mode property to each ethernet
    node

 arch/arm/boot/dts/uniphier-pro4.dtsi             | 10 +++++++---
 arch/arm/boot/dts/uniphier-pxs2.dtsi             |  3 +++
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi |  5 ++++-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi |  3 +++
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi |  8 +++++++-
 5 files changed, 24 insertions(+), 5 deletions(-)

-- 
2.7.4
