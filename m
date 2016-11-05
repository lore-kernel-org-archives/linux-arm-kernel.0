From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 6 Nov 2016 00:18:11 +0900
Subject: [GIT PULL] ARM: dts: uniphier: UniPhier DT updates for v4.10
Message-ID: <CAK7LNAQ5_Sc99WbTWR9u3_J0FqG8KUSGNQzggdQC91Cngxi+Cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here are UniPhier DT (32bit) updates for the v4.10 merge window.
Please pull!

(This time, I based this pull-request on -rc3 instead of -rc1
because I want to make sure to have no conflict
between fixes that had already been pulled-in and
new development commits in this series.)


The following changes since commit a909d3e636995ba7c349e2ca5dbb528154d4ac30:

  Linux 4.9-rc3 (2016-10-29 13:52:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt-v4.10

for you to fetch changes up to 13b4a6190b25c7bf69239bbc212d256656ada7b9:

  ARM: dts: uniphier: make compatible of syscon nodes SoC-specific
(2016-11-05 23:33:36 +0900)

----------------------------------------------------------------
UniPhier ARM SoC DT updates for v4.10

- Add OPP tables to support generic cpufreq driver
- Use more clocks/resets properties
- Misc fixes and cleanups

----------------------------------------------------------------
Masahiro Yamada (7):
      ARM: dts: uniphier: increase register region size of sysctrl node
      ARM: dts: uniphier: add CPU clocks and OPP table for Pro5 SoC
      ARM: dts: uniphier: add CPU clocks and OPP table for PXs2 SoC
      ARM: dts: uniphier: make 32bit SoC DTSI linear
      ARM: dts: uniphier: remove redundant serial fifo-size properties
      ARM: dts: uniphier: add clocks/resets to EHCI nodes of sLD3 SoC
      ARM: dts: uniphier: make compatible of syscon nodes SoC-specific

 arch/arm/boot/dts/uniphier-common32.dtsi | 199 --------------
 arch/arm/boot/dts/uniphier-ld4.dtsi      | 358 +++++++++++++++++--------
 arch/arm/boot/dts/uniphier-pro4.dtsi     | 378 +++++++++++++++++---------
 arch/arm/boot/dts/uniphier-pro5.dtsi     | 432 ++++++++++++++++++++++--------
 arch/arm/boot/dts/uniphier-pxs2.dtsi     | 399 +++++++++++++++++++--------
 arch/arm/boot/dts/uniphier-sld3.dtsi     |  21 +-
 arch/arm/boot/dts/uniphier-sld8.dtsi     | 359 +++++++++++++++++--------
 7 files changed, 1344 insertions(+), 802 deletions(-)
 delete mode 100644 arch/arm/boot/dts/uniphier-common32.dtsi


-- 
Best Regards
Masahiro Yamada
