From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 22 Jan 2017 22:41:49 +0900
Subject: [GIT PULL] ARM: dts: uniphier: UniPhier DT updates for v4.11
Message-ID: <CAK7LNAR154DLd-u50zSMTYkUN9HQtpQcnH3hGQQ69FohZp+6bA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here are UniPhier DT (32bit) updates for the v4.11 merge window.
Please pull!

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt-v4.11

for you to fetch changes up to 74b51465c02fe08f5f1e2a83d84e831e93ae8f52:

  ARM: dts: uniphier: add SD pin-mux node (2017-01-22 22:21:54 +0900)

----------------------------------------------------------------
UniPhier ARM SoC DT updates for v4.11

- Add eMMC, SD pin-mux nodes

----------------------------------------------------------------
Masahiro Yamada (2):
      ARM: dts: uniphier: add eMMC pin-mux node
      ARM: dts: uniphier: add SD pin-mux node

 arch/arm/boot/dts/uniphier-pinctrl.dtsi | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)



-- 
Best Regards
Masahiro Yamada
