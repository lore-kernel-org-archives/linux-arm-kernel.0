From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 6 Nov 2016 00:25:15 +0900
Subject: [GIT PULL] arm64: dts: uniphier: UniPhier DT updates (64bit) for v4.10
Message-ID: <CAK7LNASgYKnhpRM4jj1oHagK=MvO71QnbnaSr=Gt+hkV+6vxXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here are UniPhier DT (64bit) updates for the v4.10 merge window.
Please pull!


The following changes since commit a909d3e636995ba7c349e2ca5dbb528154d4ac30:

  Linux 4.9-rc3 (2016-10-29 13:52:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt64-v4.10

for you to fetch changes up to fb28cef06a9065748fbc6949dd7fca3c320c8e0d:

  arm64: dts: uniphier: make compatible of syscon nodes SoC-specific
(2016-11-05 23:30:11 +0900)

----------------------------------------------------------------
UniPhier ARM64 SoC DT updates for v4.10

- Switch CPU enable-method from spin-table to PSCI
- Add OPP tables to support generic cpufreq driver
- Misc fixes

----------------------------------------------------------------
Masahiro Yamada (5):
      arm64: dts: uniphier: switch over to PSCI enable method
      arm64: dts: uniphier: increase register region size of sysctrl node
      arm64: dts: uniphier: add CPU clock and OPP table for LD11 SoC
      arm64: dts: uniphier: add CPU clocks and OPP tables for LD20 SoC
      arm64: dts: uniphier: make compatible of syscon nodes SoC-specific

 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi |  59 ++++++++++--
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 111 +++++++++++++++++++---
 2 files changed, 148 insertions(+), 22 deletions(-)


-- 
Best Regards
Masahiro Yamada
