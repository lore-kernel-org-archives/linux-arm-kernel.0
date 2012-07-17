From: shiraz.hashim@st.com (Shiraz Hashim)
Date: Tue, 17 Jul 2012 18:31:50 +0530
Subject: [GIT PULL] SPEAr platform fixes over 3.5-rc7
Message-ID: <20120717130150.GM1994@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull following fixes since commit 84a1caf1453c3d44050bd22db958af4a7f99315c:

  Linux 3.5-rc7 (2012-07-14 15:40:28 -0700)

from git repository at:

  git://git.stlinux.com/spear/linux-2.6.git for-3.5-spear-fixes

with changes up to b35b8e4e63618f17dc61520515ccdcf10e6d2b57:

  ARM: SPEAr600: Fix timer interrupt definition in spear600.dtsi (2012-07-17 18:04:48 +0530)

----------------------------------------------------------------
Stefan Roese (1):
      ARM: SPEAr600: Fix timer interrupt definition in spear600.dtsi

Vipul Kumar Samar (10):
      clk:spear1340:Fix: Rename clk ids within predefined limit
      clk:spear1310:Fix: Rename clk ids within predefined limit
      Clk:spear3xx:Fix: Rename clk ids within predefined limit
      Clk:spear6xx:Fix: Rename clk ids within predefined limit
      ARM: SPEAr13xx: Fix Interrupt bindings
      clk: SPEAr1340: Fix clk enable register for uart1 and i2c1.
      clk: SPEAr13xx: Add localtimer (twd) clock support
      Clk: SPEAr1340: Update sys clock parent array
      ARM: dts: SPEAr320: Fix compatible string
      ARM: dts: SPEAr320: Boot the board in EXTENDED_MODE

 arch/arm/boot/dts/spear13xx.dtsi    |   11 +-
 arch/arm/boot/dts/spear320-evb.dts  |    6 +-
 arch/arm/boot/dts/spear600.dtsi     |    1 +
 arch/arm/mach-spear3xx/spear3xx.c   |    2 +-
 arch/arm/mach-spear6xx/spear6xx.c   |    2 +-
 drivers/clk/spear/spear1310_clock.c |  316 ++++++++++++++++++-----------------
 drivers/clk/spear/spear1340_clock.c |  283 +++++++++++++++----------------
 drivers/clk/spear/spear3xx_clock.c  |  180 ++++++++++----------
 drivers/clk/spear/spear6xx_clock.c  |  122 +++++++-------
 9 files changed, 459 insertions(+), 464 deletions(-)

--
regards
Shiraz
