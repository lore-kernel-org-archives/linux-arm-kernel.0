From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Tue, 26 Dec 2017 10:03:38 +0900
Subject: [PATCH 0/2] add has-transaction-translator property to usb node
Message-ID: <1514250220-925-1-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds has-transaction-translator property to usb node
for each SoC which has usb-ehci host controller.

Kunihiko Hayashi (2):
  ARM: dts: uniphier: add has-transaction-translator property to usb
    node for LD4, sLD8 and Pro4
  arm64: dts: uniphier: add has-transaction-translator property to usb
    node for LD11

 arch/arm/boot/dts/uniphier-ld4.dtsi              | 3 +++
 arch/arm/boot/dts/uniphier-pro4.dtsi             | 2 ++
 arch/arm/boot/dts/uniphier-sld8.dtsi             | 3 +++
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 3 +++
 4 files changed, 11 insertions(+)

-- 
2.7.4
