From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 23:19:23 +0900
Subject: [GIT PULL 00/21] Third Round of Renesas ARM Based SoC DT Updates for
 v3.14
Message-ID: <cover.1387893834.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin, Hi Olof, Hi Arnd,

please consider this third round of Renesas ARM based SoC DT updates for v3.14.

This is based on a merge of:

* The second round of Renesas ARM based SoC DT updates for v3.14,
  tagged as renesas-dt2-for-v3.14, which I have previously sent a
  pull-request for.

* The second round of Renesas ARM based SoC updates for v3.14,
  tagged as renesas-soc2-for-v3.14, which I have previously sent a
  pull-request for.

* The clk-next-shmobile branch of Mike Turquette's tree

* The clockevents/for-Simon-3.13-rc2 branch of Daniel Lezcano's tree

* The pinctl/for-next branch of Linus Walleij's tree

* v3.13-rc3


The reason for these merges is to provide dependencies for
the clock updates for the r8a7791 (R-Car M2) based Koelsch and r8a7790
(R-Car H2) based Lager boards.


The following changes since commit b652896b02df3dfde3a68957cce01f2aa4585842:

  ARM: shmobile: r8a7791: Add SSI clocks in device tree (2013-12-24 23:01:13 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt3-for-v3.14

for you to fetch changes up to b652896b02df3dfde3a68957cce01f2aa4585842:

  ARM: shmobile: r8a7791: Add SSI clocks in device tree (2013-12-24 23:01:13 +0900)

----------------------------------------------------------------
Third Round of Renesas ARM Based SoC DT Updates for v3.14

* r8a7791 (R-Car M2) and r8a7790 (R-Car H2) SoCSs
  - Add SSI, QSPI and MSIOF  clocks in device tree

r8a7791 (R-Car M2) based Koelsch and r8a7790 (R-Car H2) based Lager boards
  - Remove reference DTS
  - Specify external clock frequency in DT
  - Sync non-reference DTS with referene DTS
  - Add clocks to DTS

* r8a7740 (R-Mobile A1) based Armadillo board
  - Add gpio-keys device
  - Add PWM backlight enable GPIO
  - Add PWM backlight power supply

* r8a73a0 (SH-Mobile AG5), r8a7740 (R-Mobile A1) and
  r8a73a4 (SH-Mobile APE6) SoCs
  - Specify PFC interrupts in DT

----------------------------------------------------------------
