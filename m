From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 23 May 2013 11:48:58 +0100
Subject: [GIT PULL] ARM dts cpus/cpu nodes updates
Message-ID: <20130523104858.GA2986@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

please pull dts cpus/cpu node updates for all non-compliant ARM
SoC/boards. Please notice I could not update all dts files since some of
them are missing the cpus node altogether and I simply can not know
the CPUs configuration for them, it is up to maintainers to patch the
respective dts to comply with the latest specification.

I have just sent a different pull request for related documentation:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/170234.html

dts updates comply with those Documentation updates.

Thank you very much indeed,
Lorenzo

The following changes since commit c7788792a5e7b0d5d7f96d0766b4cb6112d47d75:

  Linux 3.10-rc2 (2013-05-20 14:37:38 -0700)

are available in the git repository at:

  git://linux-arm.org/linux-2.6-lp.git dts-cpus-updates

for you to fetch changes up to 14c44aa541744d4cf06db89c27a1e6df293c64d5:

  ARM: dts: sunxi: cpus/cpu nodes dts updates (2013-05-23 10:45:22 +0100)

----------------------------------------------------------------
Lorenzo Pieralisi (14):
      ARM: dts: am33xx: cpus/cpu nodes dts updates
      ARM: dts: armada-370-xp: cpus/cpu node dts updates
      ARM: dts: at91: cpus/cpu node dts updates
      ARM: dts: exynos5440: cpus/cpu nodes dts updates
      ARM: dts: imx: cpus/cpu nodes dts updates
      ARM: dts: lpc32xx: cpus/cpu nodes dts updates
      ARM: dts: omap: cpus/cpu nodes dts updates
      ARM: dts: picoxcell: cpus/cpu nodes dts updates
      ARM: dts: prima2: cpus/cpu node dts updates
      ARM: dts: pxa2xx: cpus/cpu nodes dts updates
      ARM: dts: r8a7740: cpus/cpu nodes dts updates
      ARM: dts: sh7372: cpus/cpu nodes dts updates
      ARM: dts: spear: cpus/cpu nodes dts updates
      ARM: dts: sunxi: cpus/cpu nodes dts updates

 arch/arm/boot/dts/am33xx.dtsi          | 4 ++++
 arch/arm/boot/dts/armada-370-xp.dtsi   | 4 ++++
 arch/arm/boot/dts/at91rm9200.dtsi      | 6 +++++-
 arch/arm/boot/dts/at91sam9260.dtsi     | 8 ++++++--
 arch/arm/boot/dts/at91sam9263.dtsi     | 8 ++++++--
 arch/arm/boot/dts/at91sam9g45.dtsi     | 8 ++++++--
 arch/arm/boot/dts/at91sam9n12.dtsi     | 8 ++++++--
 arch/arm/boot/dts/at91sam9x5.dtsi      | 8 ++++++--
 arch/arm/boot/dts/exynos5440.dtsi      | 4 ++++
 arch/arm/boot/dts/imx23.dtsi           | 8 ++++++--
 arch/arm/boot/dts/imx28.dtsi           | 8 ++++++--
 arch/arm/boot/dts/imx6dl.dtsi          | 2 ++
 arch/arm/boot/dts/imx6q.dtsi           | 4 ++++
 arch/arm/boot/dts/lpc32xx.dtsi         | 8 ++++++--
 arch/arm/boot/dts/omap2.dtsi           | 6 +++++-
 arch/arm/boot/dts/omap3.dtsi           | 5 +++++
 arch/arm/boot/dts/omap4.dtsi           | 7 +++++++
 arch/arm/boot/dts/omap5.dtsi           | 7 +++++++
 arch/arm/boot/dts/picoxcell-pc3x2.dtsi | 8 ++++----
 arch/arm/boot/dts/picoxcell-pc3x3.dtsi | 8 ++++----
 arch/arm/boot/dts/prima2.dtsi          | 2 ++
 arch/arm/boot/dts/pxa2xx.dtsi          | 7 +++++--
 arch/arm/boot/dts/r8a7740.dtsi         | 4 ++++
 arch/arm/boot/dts/sama5d3.dtsi         | 2 ++
 arch/arm/boot/dts/sh7372.dtsi          | 5 +++++
 arch/arm/boot/dts/spear13xx.dtsi       | 2 ++
 arch/arm/boot/dts/spear3xx.dtsi        | 8 ++++++--
 arch/arm/boot/dts/spear600.dtsi        | 8 ++++++--
 arch/arm/boot/dts/sun4i-a10.dtsi       | 2 ++
 arch/arm/boot/dts/sun5i-a13.dtsi       | 2 ++
 30 files changed, 139 insertions(+), 32 deletions(-)
