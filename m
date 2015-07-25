From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 25 Jul 2015 16:23:21 +0900
Subject: [PATCH 0/3] ARM: UniPhier: update DTS and MAINTAINERS
Message-ID: <1437809004-16806-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

The pinctrl drivers for UniPhier SoCs were accepted by Linus Walleij
into the linux-pinctrl subsystem.

Here is a small series I'd like you to merge into the ARM-SOC subsystem
to use my pinctrl drivers.



Masahiro Yamada (3):
  ARM: dts: UniPhier: add pinctrl device nodes
  ARM: dts: UniPhier: add UART and USB pinmux nodes
  MAINTAINERS: add entries for UniPhier device trees and drivers

 MAINTAINERS                              |  3 ++
 arch/arm/boot/dts/uniphier-ph1-ld4.dtsi  | 22 +++++++++
 arch/arm/boot/dts/uniphier-ph1-pro4.dtsi | 20 ++++++++
 arch/arm/boot/dts/uniphier-ph1-sld8.dtsi | 22 +++++++++
 arch/arm/boot/dts/uniphier-pinctrl.dtsi  | 85 ++++++++++++++++++++++++++++++++
 5 files changed, 152 insertions(+)
 create mode 100644 arch/arm/boot/dts/uniphier-pinctrl.dtsi

-- 
1.9.1
