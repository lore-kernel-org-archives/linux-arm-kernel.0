From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 19 Mar 2015 11:15:21 +0900
Subject: [GIT PULL] Third Round of Renesas ARM Based SoC DT Updates for v4.1
Message-ID: <cover.1426731062.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these third round of Renesas ARM based SoC DT updates for v4.1.

This pull request is based on the previous round of
such requests, tagged as renesas-dt2-for-v4.1,
which you have already pulled.


The following changes since commit 90ca409a1e6b9b72d1b6ae716cd7a63335fd0e87:

  ARM: shmobile: ape6evm dts: Configure the custom switch as wake-up source (2015-03-07 10:07:30 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt3-for-v4.1

for you to fetch changes up to 63573339e7698503bfeaef3bb0c444ffc98e45a0:

  ARM: shmobile: r8a7791: sound enables Audio DMAC entry on DTSI (2015-03-11 09:40:30 +0900)

----------------------------------------------------------------
Third Round of Renesas ARM Based SoC DT Updates for v4.1

* Add DMA sound support to r8a7791 and r8a7790 SoCs

----------------------------------------------------------------
Kuninori Morimoto (6):
      ARM: shmobile: r8a7790: add reg-names for sound
      ARM: shmobile: r8a7791: add reg-names for sound
      ARM: shmobile: r8a7790: enable Audio DMAC peri peri via sound driver
      ARM: shmobile: r8a7791: enable Audio DMAC peri peri via sound driver
      ARM: shmobile: r8a7790: sound enables Audio DMAC entry on DTSI
      ARM: shmobile: r8a7791: sound enables Audio DMAC entry on DTSI

 arch/arm/boot/dts/r8a7790.dtsi | 142 ++++++++++++++++++++++++++++++++---------
 arch/arm/boot/dts/r8a7791.dtsi | 142 ++++++++++++++++++++++++++++++++---------
 2 files changed, 224 insertions(+), 60 deletions(-)
