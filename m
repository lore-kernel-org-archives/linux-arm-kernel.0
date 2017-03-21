From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 22 Mar 2017 08:46:51 +0900
Subject: [GIT PULL] ARM: dts: uniphier: UniPhier DT updates for v4.12
Message-ID: <CAK7LNAScRBfD_2kDZYtr0S83kvLhSHAs0C4HjprNr5dKCSPRcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here are UniPhier DT (32bit) updates for the v4.12 merge window.
Please pull!


The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt-v4.12

for you to fetch changes up to facc7a551cda4c7091b0413438b280e654659890:

  ARM: dts: uniphier: add pagesize property to EEPROM of proto boards
(2017-03-14 05:02:13 +0900)

----------------------------------------------------------------
UniPhier ARM SoC DT updates for v4.12

- Remove skeleton.dtsi inclusion
- Fix W=* build warnings
- Fix eMMC pin-mux node
- Add pagesize properties to EEPROM nodes

----------------------------------------------------------------
Masahiro Yamada (6):
      ARM: dts: uniphier: remove skeleton.dtsi inclusion
      ARM: dts: uniphier: fix no unit name warnings
      ARM: dts: uniphier: move memory node below aliases node
      ARM: dts: uniphier: fix pin groups of eMMC pin-mux node
      ARM: dts: uniphier: add pagesize property to EEPROM of Support Card
      ARM: dts: uniphier: add pagesize property to EEPROM of proto boards

 arch/arm/boot/dts/uniphier-ld4-ref.dts       | 10 +++++-----
 arch/arm/boot/dts/uniphier-ld4.dtsi          |  4 ++--
 arch/arm/boot/dts/uniphier-ld6b-ref.dts      | 10 +++++-----
 arch/arm/boot/dts/uniphier-pinctrl.dtsi      |  2 +-
 arch/arm/boot/dts/uniphier-pro4-ace.dts      | 11 ++++++-----
 arch/arm/boot/dts/uniphier-pro4-ref.dts      | 10 +++++-----
 arch/arm/boot/dts/uniphier-pro4-sanji.dts    | 11 ++++++-----
 arch/arm/boot/dts/uniphier-pro4.dtsi         |  4 ++--
 arch/arm/boot/dts/uniphier-pro5.dtsi         |  4 ++--
 arch/arm/boot/dts/uniphier-pxs2-gentil.dts   | 11 ++++++-----
 arch/arm/boot/dts/uniphier-pxs2-vodka.dts    | 10 +++++-----
 arch/arm/boot/dts/uniphier-pxs2.dtsi         |  4 ++--
 arch/arm/boot/dts/uniphier-ref-daughter.dtsi |  4 +++-
 arch/arm/boot/dts/uniphier-sld3-ref.dts      | 12 ++++++------
 arch/arm/boot/dts/uniphier-sld3.dtsi         |  4 ++--
 arch/arm/boot/dts/uniphier-sld8-ref.dts      | 10 +++++-----
 arch/arm/boot/dts/uniphier-sld8.dtsi         |  4 ++--
 arch/arm/boot/dts/uniphier-support-card.dtsi |  5 +++--
 18 files changed, 68 insertions(+), 62 deletions(-)


-- 
Best Regards
Masahiro Yamada
