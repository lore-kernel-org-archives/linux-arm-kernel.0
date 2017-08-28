From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 29 Aug 2017 00:23:32 +0900
Subject: [GIT PULL] ARM: dts: uniphier: UniPhier DT updates for v4.14
Message-ID: <CAK7LNAQrKNRWTAe-bRU2UvE6fJPrrL0Vp-yGEKDeT+ktKu-ioQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Sorry for my last-minute pull request.
Please pull a little more for the upcoming merge window.
Here are some trivial UniPhier DT (32bit) updates.  Please pull!



The following changes since commit 69f9cdc63319e5ccc210b30d1cec1dfda7096b04:

  ARM: dts: uniphier: add Denali NAND controller node (2017-08-16
01:47:01 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt-v4.14-2

for you to fetch changes up to 8a7a516afaed2ee6b5da551a01c573eba3b69c16:

  ARM: dts: uniphier: add pinctrl groups of ethernet phy mode
(2017-08-29 00:00:43 +0900)

----------------------------------------------------------------
UniPhier ARM SoC DT updates for v4.14 (2nd)

- add AIDET irqchip device nodes
- fix size of sdctrl node
- add ethernet pinmux nodes

----------------------------------------------------------------
Kunihiko Hayashi (1):
      ARM: dts: uniphier: add pinctrl groups of ethernet phy mode

Masahiro Yamada (2):
      ARM: dts: uniphier: add AIDET nodes
      ARM: dts: uniphier: fix size of sdctrl nodes

 arch/arm/boot/dts/uniphier-ld4.dtsi     |  7 +++++++
 arch/arm/boot/dts/uniphier-pinctrl.dtsi | 15 +++++++++++++++
 arch/arm/boot/dts/uniphier-pro4.dtsi    |  7 +++++++
 arch/arm/boot/dts/uniphier-pro5.dtsi    |  9 ++++++++-
 arch/arm/boot/dts/uniphier-pxs2.dtsi    |  9 ++++++++-
 arch/arm/boot/dts/uniphier-sld8.dtsi    |  7 +++++++
 6 files changed, 52 insertions(+), 2 deletions(-)


-- 
Best Regards
Masahiro Yamada
