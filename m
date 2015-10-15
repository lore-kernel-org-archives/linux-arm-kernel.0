From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 15 Oct 2015 18:05:31 +0900
Subject: [PATCH 0/3] ARM: dts: uniphier: DTS updates for UniPhier SoCs for
 Linux 4.14-rc1
Message-ID: <1444899934-4754-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof and Arnd,

Please apply this series to ARM-SOC for the next merge window.

Thanks
Masahiro Yamada



Masahiro Yamada (3):
  ARM: dts: uniphier: change the external bus address mapping
  ARM: dts: uniphier: add ProXstream2 Vodka board support
  ARM: dts: uniphier: add ProXstream2 Gentil board support

 arch/arm/boot/dts/Makefile                        |  4 +-
 arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts        |  5 +-
 arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts       |  5 +-
 arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts       |  5 +-
 arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts       |  5 +-
 arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts       |  5 +-
 arch/arm/boot/dts/uniphier-proxstream2-gentil.dts | 79 +++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-proxstream2-vodka.dts  | 79 +++++++++++++++++++++++
 8 files changed, 171 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm/boot/dts/uniphier-proxstream2-gentil.dts
 create mode 100644 arch/arm/boot/dts/uniphier-proxstream2-vodka.dts

-- 
1.9.1
