From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 24 Oct 2017 02:36:54 +0900
Subject: [GIT PULL] ARM: dts: uniphier: UniPhier DT updates for v4.15
Message-ID: <CAK7LNAS+o7zCL_Yf7YXeqFMs2uNwTQ5O06+mmzeJqwsgzJzXMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here are UniPhier DT (32bit) updates for the v4.15 merge window.
Please pull!



The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt-v4.15

for you to fetch changes up to a1763a82a3e5896fa39b9e4e7b9f42c8f39390ae:

  ARM: dts: uniphier: add resets properties (2017-10-24 02:12:48 +0900)

----------------------------------------------------------------
UniPhier ARM SoC DT updates for v4.15

- add thermal monitor and thermal zone nodes
- fix W=2 warnings
- add GPIO controller nodes and related properties
- add resets properties

----------------------------------------------------------------
Kunihiko Hayashi (1):
      ARM: dts: uniphier: add nodes of thermal monitor and thermal zone for PXs2

Masahiro Yamada (5):
      ARM: dts: uniphier: fix W=2 build warnings
      ARM: dts: uniphier: add GPIO controller nodes
      ARM: dts: uniphier: route on-board device IRQ to GPIO controller
      ARM: dts: uniphier: add GPIO hog definition
      ARM: dts: uniphier: add resets properties

 arch/arm/boot/dts/uniphier-ld4-ref.dts       | 10 ++-
 arch/arm/boot/dts/uniphier-ld4.dtsi          | 25 +++++-
 arch/arm/boot/dts/uniphier-ld6b-ref.dts      | 10 ++-
 arch/arm/boot/dts/uniphier-pinctrl.dtsi      | 46 +++++-----
 arch/arm/boot/dts/uniphier-pro4-ref.dts      | 10 ++-
 arch/arm/boot/dts/uniphier-pro4.dtsi         | 27 +++++-
 arch/arm/boot/dts/uniphier-pro5.dtsi         | 29 ++++++-
 arch/arm/boot/dts/uniphier-pxs2.dtsi         | 80 ++++++++++++++++--
 arch/arm/boot/dts/uniphier-sld8-ref.dts      | 10 ++-
 arch/arm/boot/dts/uniphier-sld8.dtsi         | 29 ++++++-
 arch/arm/boot/dts/uniphier-support-card.dtsi |  3 +-
 11 files changed, 240 insertions(+), 39 deletions(-)


-- 
Best Regards
Masahiro Yamada
