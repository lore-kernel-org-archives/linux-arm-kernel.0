From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 21 Oct 2015 20:36:26 +0900
Subject: [PATCH 0/4] ARM: dts: uniphier: DTS updates for UniPhier SoCs for
 Linux 4.14-rc1 (2nd try)
Message-ID: <1445427390-22750-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

I dropped I2C aliases.
(I want this policy to be consistent for all the uniphier DTS files.
2/4 deletes them from existing DTS files too.)

Please pull this series for the next merge window.

Thanks,
Masahiro



Masahiro Yamada (4):
  ARM: dts: uniphier: use stdout-path instead of console
  ARM: dts: uniphier: delete i2c aliases
  ARM: dts: uniphier: add ProXstream2 Gentil board support
  ARM: dts: uniphier: add ProXstream2 Vodka board support

 arch/arm/boot/dts/Makefile                        |  4 +-
 arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts        |  7 +--
 arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts       | 10 +--
 arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts       |  9 +--
 arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts       |  8 +--
 arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts       |  7 +--
 arch/arm/boot/dts/uniphier-proxstream2-gentil.dts | 74 +++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-proxstream2-vodka.dts  | 74 +++++++++++++++++++++++
 8 files changed, 156 insertions(+), 37 deletions(-)
 create mode 100644 arch/arm/boot/dts/uniphier-proxstream2-gentil.dts
 create mode 100644 arch/arm/boot/dts/uniphier-proxstream2-vodka.dts

-- 
1.9.1
