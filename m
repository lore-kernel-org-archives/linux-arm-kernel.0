From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 20 May 2018 11:34:08 +0900
Subject: [GIT PULL] ARM: dts: uniphier: UniPhier DT updates for v4.18
Message-ID: <CAK7LNATphrRyYvMXMMJz--UtfNk2BZLWHAp3XXpQLob5=5w2Qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here are UniPhier DT (32bit) updates for the v4.18 merge window.
Please pull!


The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt-v4.18

for you to fetch changes up to 526f872b8492fbfb1a0f342e601bdc5ba322f16b:

  ARM: dts: uniphier: add syscon-phy-mode property to each ethernet
node (2018-04-25 00:21:51 +0900)

----------------------------------------------------------------
UniPhier ARM SoC DT updates for v4.18

- add more properties to ethernet nodes

----------------------------------------------------------------
Kunihiko Hayashi (2):
      ARM: dts: uniphier: add required clocks and resets to Pro4 ethernet node
      ARM: dts: uniphier: add syscon-phy-mode property to each ethernet node

 arch/arm/boot/dts/uniphier-pro4.dtsi | 10 +++++++---
 arch/arm/boot/dts/uniphier-pxs2.dtsi |  3 +++
 2 files changed, 10 insertions(+), 3 deletions(-)



-- 
Best Regards
Masahiro Yamada
