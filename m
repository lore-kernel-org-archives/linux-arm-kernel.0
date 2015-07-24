From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 24 Jul 2015 17:41:29 +0900
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC DT Updates for v4.3
Message-ID: <cover.1437724902.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC DT updates for v4.3.

This pull request is based on the previous round of
such requests, tagged as renesas-dt-for-v4.3,
which I have already sent a pull-request for.


The following changes since commit 7bf46d0be278a3586c78322c65ceff5fd03bb95d:

  ARM: shmobile: r8a7779: Configure IRLM mode via DT (2015-07-06 09:33:41 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt2-for-v4.3

for you to fetch changes up to 7fd6e11dca09b21efbe2b9db4eff08c8f4a16125:

  ARM: shmobile: r8a7791: Add Audio MIX support on DTSI (2015-07-22 09:36:49 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC DT Updates for v4.3

* Add Audio MIX and CTU support to r8a779[01] SoCs
* Correct IRQ sense for adv7511 on lager board
* Add sound label to koelsch and lager boards
* Add IIC support to emev2 SoC

----------------------------------------------------------------
Kuninori Morimoto (6):
      ARM: shmobile: lager: add sound label on DTS
      ARM: shmobile: koelsch: add sound label on DTS
      ARM: shmobile: r8a7790: Add Audio CTU support on DTSI
      ARM: shmobile: r8a7790: Add Audio MIX support on DTSI
      ARM: shmobile: r8a7791: Add Audio CTU support on DTSI
      ARM: shmobile: r8a7791: Add Audio MIX support on DTSI

Laurent Pinchart (1):
      ARM: shmobile: lager: Fix adv7511 IRQ sensing

Wolfram Sang (2):
      ARM: shmobile: emev2: add IIC cores to dtsi
      ARM: shmobile: emev2: kzm9d: enable IIC busses

 arch/arm/boot/dts/emev2-kzm9d.dts         |  8 ++++++
 arch/arm/boot/dts/emev2.dtsi              | 48 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7790-lager.dts       |  4 +--
 arch/arm/boot/dts/r8a7790.dtsi            | 23 +++++++++++++++
 arch/arm/boot/dts/r8a7791-koelsch.dts     |  2 +-
 arch/arm/boot/dts/r8a7791.dtsi            | 23 +++++++++++++++
 include/dt-bindings/clock/r8a7790-clock.h |  2 ++
 include/dt-bindings/clock/r8a7791-clock.h |  2 ++
 8 files changed, 109 insertions(+), 3 deletions(-)
