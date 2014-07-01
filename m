From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Jul 2014 09:28:19 +0900
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC DT Updates for v3.17
Message-ID: <cover.1404174433.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Second Round of Renesas ARM Based SoC DT Updates
for v3.17.

This pull request is based on the previous round of
such requests, tagged as renesas-dt-for-v3.17,
which I have already sent a pull-request for.


The following changes since commit 09abd1fd11f98d6abde9c23244234170e7e36c2f:

  ARM: shmobile: r8a7791: add R-Car sound support on DTSI (2014-06-17 19:58:32 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git renesas-dt2-for-v3.17

for you to fetch changes up to 150c8ad40808189423002ea9fc6a858a3a59e6dc:

  ARM: shmobile: r8a7791: add DVC support for sound node on DTSI (2014-06-28 09:02:19 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC DT Updates for v3.17

* Extend hardware coverage
  - Add DVC support for sound nodes on r8a7791 and r8a7790
  - Enable internal PCI on r8a7790/lager

----------------------------------------------------------------
Ben Dooks (2):
      ARM: shmobile: r8a7790: add internal PCI bridge nodes
      ARM: shmobile: lager: enable internal PCI

Kuninori Morimoto (2):
      ARM: shmobile: r8a7790: add DVC support for sound node on DTSI
      ARM: shmobile: r8a7791: add DVC support for sound node on DTSI

 arch/arm/boot/dts/r8a7790-lager.dts | 33 ++++++++++++++++++
 arch/arm/boot/dts/r8a7790.dtsi      | 67 +++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7791.dtsi      |  7 ++++
 3 files changed, 107 insertions(+)
