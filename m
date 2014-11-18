From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 18 Nov 2014 09:51:12 +0900
Subject: [GIT PULL] Third Round of Renesas ARM Based SoC DT Cleanups for v3.19
Message-ID: <cover.1416271777.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these third round of Renesas ARM based SoC DT cleanups for
v3.19.

This pull request is based on the previous round of
such requests, tagged as renesas-dt-cleanups2-for-v3.19,
which I have already sent a pull-request for.


The following changes since commit 89aeff9989e87bb2d9d652994010bc18c68675d9:

  ARM: shmobile: alt dts: Drop console= bootargs parameter (2014-11-05 14:54:10 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-cleanups3-for-v3.19

for you to fetch changes up to 61f1fb47bdbcf145dd539d29cfa7f3294bd5e958:

  ARM: shmobile: kzm9g-reference: Use keyboard as gpio-keys node name (2014-11-14 09:39:47 +0900)

----------------------------------------------------------------
Third Round of Renesas ARM Based SoC DT Cleanups for v3.19

* Use keyboard as gpio-keys node name

----------------------------------------------------------------
Simon Horman (4):
      ARM: shmobile: armadillo800eva: Use keyboard as gpio-keys node name
      ARM: shmobile: lager: Use keyboard as gpio-keys node name
      ARM: shmobile: koelsch: Use keyboard as gpio-keys node name
      ARM: shmobile: kzm9g-reference: Use keyboard as gpio-keys node name

 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 2 +-
 arch/arm/boot/dts/r8a7790-lager.dts           | 2 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts         | 2 +-
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
