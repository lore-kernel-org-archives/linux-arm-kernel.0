From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 5 Mar 2014 10:57:24 +0800
Subject: [GIT PULL]ARM: sirf: machine update for 3.15
Message-ID: <CAGsJ_4wcp-vTJH=xm-4HjqvTHY1Q0E8cbnTGTk6z72DmwNCy1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guys,

most of the below are some minor fixes for coding style. "ARM: prima2:
move to generic reset controller driver framework"
has been ready near 3.14 merge window, but it was late to merge in
3.14, so move this one to 3.15.

Thanks
barry


The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/baohua/linux.git
tags/sirf-soc-for-3.15

for you to fetch changes up to e7eda91f6323bd7dc85598c639f5e4709efc2309:

  ARM: prima2: move to generic reset controller driver framework
(2014-03-05 10:33:47 +0800)

----------------------------------------------------------------
ARM: sirf: machine update for 3.15

Among them:
  ARM: prima2: l2x0: fix checkpatch issues
  ARM: prima2: platsmp: fix checkpatch issues
  ARM: prima2: common: fix checkpatch issues
  ARM: prima2: rtciobrg: fix the typo about license
  ARM: prima2: staticize sirfsoc_init_late function
  ARM: prima2: move to generic reset controller driver framework

----------------------------------------------------------------
Barry Song (6):
      ARM: prima2: l2x0: fix checkpatch issues
      ARM: prima2: platsmp: fix checkpatch issues
      ARM: prima2: common: fix checkpatch issues
      ARM: prima2: rtciobrg: fix the typo about license
      ARM: prima2: staticize sirfsoc_init_late function
      ARM: prima2: move to generic reset controller driver framework

 .../devicetree/bindings/reset/sirf,rstc.txt        |   42 +++++++++
 arch/arm/boot/dts/atlas6.dtsi                      |    3 +-
 arch/arm/boot/dts/marco.dtsi                       |    3 +-
 arch/arm/boot/dts/prima2.dtsi                      |    3 +-
 arch/arm/mach-prima2/Kconfig                       |    1 +
 arch/arm/mach-prima2/common.c                      |    8 +-
 arch/arm/mach-prima2/l2x0.c                        |    9 +-
 arch/arm/mach-prima2/platsmp.c                     |    6 +-
 arch/arm/mach-prima2/rstc.c                        |   93 +++++++++++++-------
 arch/arm/mach-prima2/rtciobrg.c                    |    2 +-
 10 files changed, 120 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/sirf,rstc.txt

-barry
