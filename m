From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 14 Jan 2015 21:22:36 +0800
Subject: [GIT PULL RESEND] CSR atlas7 init dts for 3.20
Message-ID: <CAGsJ_4w8=P6GDcW+z3DT4-C7Rdf_OjoBPHmoMA7wvNoTCLFYeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

The following changes since commit b7392d2247cfe6771f95d256374f1a8e6a6f48d6:

  Linux 3.19-rc2 (2014-12-28 16:49:37 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/baohua/linux.git
tags/atlas7-init-dts-for-3.20

for you to fetch changes up to 7d76d03b9be8ea8977df45176336cc4fec6ac603:

  ARM: dts: add init dts file for CSR atlas7 SoC (2015-01-13 22:19:23 +0800)

----------------------------------------------------------------
drop Marco and add init dts stuff for Atlas7

CSR Marco SoC has never shipped to customers that could be interested
in mainline support. and new Atlas7 is a replacement SoC that is in
development.

so we drop Marco dts stuff, and add dts stuff for Atlas7.

----------------------------------------------------------------
Barry Song (1):
      ARM: dts: drop MARCO platform DT stuff

Zhiwu Song (1):
      ARM: dts: add init dts file for CSR atlas7 SoC

 Documentation/devicetree/bindings/arm/sirf.txt |    6 +-
 arch/arm/boot/dts/Makefile                     |    2 +-
 arch/arm/boot/dts/atlas7-evb.dts               |  110 ++++
 arch/arm/boot/dts/atlas7.dtsi                  |  813 ++++++++++++++++++++++++
 arch/arm/boot/dts/marco-evb.dts                |   54 --
 arch/arm/boot/dts/marco.dtsi                   |  757 ----------------------
 6 files changed, 928 insertions(+), 814 deletions(-)
 create mode 100644 arch/arm/boot/dts/atlas7-evb.dts
 create mode 100644 arch/arm/boot/dts/atlas7.dtsi
 delete mode 100644 arch/arm/boot/dts/marco-evb.dts
 delete mode 100644 arch/arm/boot/dts/marco.dtsi

-barry
