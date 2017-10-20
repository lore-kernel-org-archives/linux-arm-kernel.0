From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 21 Oct 2017 02:16:38 +0900
Subject: [GIT PULL] ARM: uniphier: fixes for v4.14
Message-ID: <CAK7LNARdGT2zpbGLgv9fCgn+i96AH1pwNgy3mDJxGxBSiJEJwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull small fixes of ARM UniPhier DT.
It turned out one clock was missing that is actually
necessary for EHCI nodes.



The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-fixes-v4.14

for you to fetch changes up to deaa55196e0cb6eccc3d5374ddd7c47e7ec61da3:

  arm64: dts: uniphier: add STDMAC clock to EHCI nodes (2017-10-21
01:24:05 +0900)

----------------------------------------------------------------
UniPhier ARM SoC fixes for v4.14

- Add necessary clock to EHCI node

----------------------------------------------------------------
Masahiro Yamada (2):
      ARM: dts: uniphier: add STDMAC clock to EHCI nodes
      arm64: dts: uniphier: add STDMAC clock to EHCI nodes

 arch/arm/boot/dts/uniphier-ld4.dtsi              | 9 ++++++---
 arch/arm/boot/dts/uniphier-pro4.dtsi             | 6 ++++--
 arch/arm/boot/dts/uniphier-sld8.dtsi             | 9 ++++++---
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 9 ++++++---
 4 files changed, 22 insertions(+), 11 deletions(-)


-- 
Best Regards
Masahiro Yamada
