From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 12 Aug 2015 17:15:25 +0900
Subject: [GIT PULL] Fourth Round of Renesas ARM Based SoC DT Updates for v4.3
Message-ID: <cover.1439366241.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these fourth round of Renesas ARM based SoC DT updates for v4.3.

As requested by Olof, this is a repost of patches broken out of a now
defunct pull-request, "Renesas ARM Based SoC CPG MSTP Clock Domain Updates
for v4.3".  The motivation being to have driver changes in a separate
branch to DT changes.


This pull request is based on a merge of:

* "Renesas ARM Based SoC CPG/MSTP Clock Driver Updates for v4.3",
  tagged as renesas-clk-for-v4.3, which I have also sent a pull request for.

  The patches in this pull request depend on driver changes in
  renesas-clk-for-v4.3.

* "Third Round of Renesas ARM Based SoC DT Updates for v4.3",
  tagged as renesas-dt3-for-v4.3, which you have already merged.

  The patches in this pull request update nodes added by patches
  present in renesas-dt3-for-v4.3.


The following changes since commit 3f3f0ea0afe031ca20e48a212f4faa00f9920450:

  Merge branch 'clk-for-v4.3' into dt-for-v4.3 (2015-08-12 11:15:19 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt4-for-v4.3

for you to fetch changes up to 60c0745a80be075bbd4e0925e4b740b3e588a445:

  ARM: shmobile: r8a7794 dtsi: Add CPG/MSTP Clock Domain (2015-08-12 11:15:28 +0900)

----------------------------------------------------------------
Fourth Round of Renesas ARM Based SoC DT Updates for v4.3

* Enable Clock Domain support of the Clock Pulse Generator (CPG)
  Module Stop (MSTP) Clocks driver.

----------------------------------------------------------------
Geert Uytterhoeven (7):
      ARM: shmobile: r7s72100 dtsi: Add CPG/MSTP Clock Domain
      ARM: shmobile: r8a7778 dtsi: Add CPG/MSTP Clock Domain
      ARM: shmobile: r8a7779 dtsi: Add CPG/MSTP Clock Domain
      ARM: shmobile: r8a7790 dtsi: Add CPG/MSTP Clock Domain
      ARM: shmobile: r8a7791 dtsi: Add CPG/MSTP Clock Domain
      ARM: shmobile: r8a7793 dtsi: Add CPG/MSTP Clock Domain
      ARM: shmobile: r8a7794 dtsi: Add CPG/MSTP Clock Domain

 arch/arm/boot/dts/r7s72100.dtsi | 19 +++++++++
 arch/arm/boot/dts/r8a7778.dtsi  | 22 +++++++++++
 arch/arm/boot/dts/r8a7779.dtsi  | 23 +++++++++++
 arch/arm/boot/dts/r8a7790.dtsi  | 86 +++++++++++++++++++++++++++++++++++-----
 arch/arm/boot/dts/r8a7791.dtsi  | 88 +++++++++++++++++++++++++++++++++++++----
 arch/arm/boot/dts/r8a7793.dtsi  |  7 ++++
 arch/arm/boot/dts/r8a7794.dtsi  | 29 ++++++++++++++
 7 files changed, 257 insertions(+), 17 deletions(-)
