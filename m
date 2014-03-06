From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Mar 2014 13:44:28 +0900
Subject: [GIT PULL] Fourth Round of Renesas ARM Based SoC DT Updates for v3.15
Message-ID: <cover.1394080829.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider this fourth round of Renesas ARM based SoC DT updates for v3.15.

This pull request is based on the previous round of
such requests, tagged as renesas-dt3-for-v3.15,
which I have already sent a pull-request for.


The following changes since commit 367aaaea1d6c6496695ffd06b49590b8cfcb8aa5:

  ARM: shmobile: genmai: adapt dts to use native i2c driver (2014-02-18 11:35:30 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt4-for-v3.15

for you to fetch changes up to 2c60a7df72711fb8b4be1e6aa651ab166a8931bc:

  ARM: shmobile: Add SDHI devices for Koelsch DTS (2014-02-26 15:11:41 +0900)

----------------------------------------------------------------
Fourth Round of Renesas ARM Based SoC DT Updates for v3.15

* r8a7791 (R-Car M2) based koelsch board
  - Add SDHI devices
  - Add ethernet

* r8a7791 (R-Car M2) SoC
  - Correct clock index for i2c5

* r8a7790 (R-Car H2) based lager board
  - Add ethernet

----------------------------------------------------------------
Magnus Damm (2):
      ARM: shmobile: Add SDHI devices to r8a7791 DTSI
      ARM: shmobile: Add SDHI devices for Koelsch DTS

Sergei Shtylyov (4):
      ARM: shmobile: r8a7790: add Ether DT support
      ARM: shmobile: lager: add Ether DT support
      ARM: shmobile: r8a7791: add Ether DT support
      ARM: shmobile: koelsch: add Ether DT support

Wolfram Sang (1):
      ARM: shmobile: r8a7791: fix clock index for i2c5

 arch/arm/boot/dts/r8a7790-lager.dts   |  28 ++++++-
 arch/arm/boot/dts/r8a7790.dtsi        |  14 +++-
 arch/arm/boot/dts/r8a7791-koelsch.dts | 147 +++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/r8a7791.dtsi        |  43 +++++++++-
 4 files changed, 227 insertions(+), 5 deletions(-)
