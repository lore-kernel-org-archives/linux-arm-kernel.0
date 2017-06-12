From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 13 Jun 2017 00:41:04 +0900
Subject: [GIT PULL] ARM: dts: uniphier: UniPhier DT updates for v4.13
Message-ID: <CAK7LNASkEJOdbpOu7rf9WYZsTbbfnW=hyiHxV9w8jOD=WMmCew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here are UniPhier DT (32bit) updates for the v4.13 merge window.
Please pull!


The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt-v4.13

for you to fetch changes up to 73f9de0c7f5dd9eae6949135a7b316cb02365519:

  ARM: dts: uniphier: Add generic compatible string for I2C EEPROM
(2017-06-10 01:10:41 +0900)

----------------------------------------------------------------
UniPhier ARM SoC DT updates for v4.13

- fix W=1 build warnings
- use SPDX License Identifier
- add generic compatible string for I2C EEPROM

----------------------------------------------------------------
Javier Martinez Canillas (1):
      ARM: dts: uniphier: Add generic compatible string for I2C EEPROM

Masahiro Yamada (2):
      ARM: dts: uniphier: fix simple-bus unit address format error
      ARM: dts: uniphier: use SPDX-License-Identifier

Viresh Kumar (1):
      ARM: dts: uniphier: Use - instead of @ for DT OPP entries

 arch/arm/boot/dts/uniphier-ld4-ref.dts       | 38 +-------------------
 arch/arm/boot/dts/uniphier-ld4.dtsi          | 40 ++-------------------
 arch/arm/boot/dts/uniphier-ld6b-ref.dts      | 38 +-------------------
 arch/arm/boot/dts/uniphier-ld6b.dtsi         | 38 +-------------------
 arch/arm/boot/dts/uniphier-pro4-ace.dts      | 40 ++-------------------
 arch/arm/boot/dts/uniphier-pro4-ref.dts      | 38 +-------------------
 arch/arm/boot/dts/uniphier-pro4-sanji.dts    | 40 ++-------------------
 arch/arm/boot/dts/uniphier-pro4.dtsi         | 40 ++-------------------
 arch/arm/boot/dts/uniphier-pro5.dtsi         | 34 +++++++++---------
 arch/arm/boot/dts/uniphier-pxs2-gentil.dts   | 40 ++-------------------
 arch/arm/boot/dts/uniphier-pxs2-vodka.dts    | 38 +-------------------
 arch/arm/boot/dts/uniphier-pxs2.dtsi         | 56 ++++++-----------------------
 arch/arm/boot/dts/uniphier-ref-daughter.dtsi | 38 +-------------------
 arch/arm/boot/dts/uniphier-sld3-ref.dts      | 38 +-------------------
 arch/arm/boot/dts/uniphier-sld3.dtsi         | 40 ++-------------------
 arch/arm/boot/dts/uniphier-sld8-ref.dts      | 38 +-------------------
 arch/arm/boot/dts/uniphier-sld8.dtsi         | 40 ++-------------------
 arch/arm/boot/dts/uniphier-support-card.dtsi | 42 ++--------------------
 18 files changed, 52 insertions(+), 664 deletions(-)


-- 
Best Regards
Masahiro Yamada
