From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 29 Nov 2017 23:01:57 +0900
Subject: [GIT PULL] ARM: uniphier: fixes for v4.15
Message-ID: <CAK7LNARMXg-3Xfz2Mxq47Suys4kPSWuPYKY1o8HkVRBd4fHfSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here are some fixes of ARM UniPhier SoC family.
There is a mistake in the IRQ number.  Otherwise, I wouldn't have done
this early pull request.  One more trivial patch to avoid conflict.
Also, MAINTAINERS update, which is always safe.
Please pull!


The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-fixes-v4.15

for you to fetch changes up to 0308cadcec379e510f498c48c34aafe582f1af88:

  MAINTAINERS: exclude other Socionext SoC DT files from ARM/UNIPHIER
entry (2017-11-29 22:22:10 +0900)

----------------------------------------------------------------
UniPhier ARM SoC fixes for v4.15

- Fix IRQ number of PXs3 SoC
- Remove redundant interrupt-parent properties
- Fix arm64 DT path in MAINTAINERS

----------------------------------------------------------------
Dai Okamura (1):
      arm64: dts: uniphier: correct on-board device IRQ number for PXs3

Masahiro Yamada (2):
      arm64: dts: uniphier: remove unnecessary interrupt-parent
      MAINTAINERS: exclude other Socionext SoC DT files from ARM/UNIPHIER entry

 MAINTAINERS                                         | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts | 1 -
 arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts | 1 -
 arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts | 3 +--
 4 files changed, 2 insertions(+), 5 deletions(-)


-- 
Best Regards
Masahiro Yamada
