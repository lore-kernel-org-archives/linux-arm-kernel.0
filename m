From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Dec 2014 10:43:39 +0900
Subject: [GIT PULL] Renesas ARM Based SoC DT Cleanups for v3.20
Message-ID: <cover.1419809027.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT cleanups for v3.20.


The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-cleanups-for-v3.20

for you to fetch changes up to 338d1f0b5e877eae51c885da81d86b0efd6373e7:

  ARM: shmobile: kzm9g-reference dts: Replace status value "ok" by "okay" (2014-12-21 16:55:32 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC DT Cleanups for v3.20

* Replace status value "ok" with "okay"

----------------------------------------------------------------
Geert Uytterhoeven (7):
      ARM: shmobile: genmai dts: Replace status value "ok" by "okay"
      ARM: shmobile: armadillo800eva dts: Replace status value "ok" by "okay"
      ARM: shmobile: lager dts: Replace status value "ok" by "okay"
      ARM: shmobile: henninger dts: Replace status value "ok" by "okay"
      ARM: shmobile: koelsch dts: Replace status value "ok" by "okay"
      ARM: shmobile: alt dts: Replace status value "ok" by "okay"
      ARM: shmobile: kzm9g-reference dts: Replace status value "ok" by "okay"

 arch/arm/boot/dts/r7s72100-genmai.dts         |  2 +-
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts |  4 ++--
 arch/arm/boot/dts/r8a7790-lager.dts           | 12 ++++++------
 arch/arm/boot/dts/r8a7791-henninger.dts       |  4 ++--
 arch/arm/boot/dts/r8a7791-koelsch.dts         |  6 +++---
 arch/arm/boot/dts/r8a7794-alt.dts             |  4 ++--
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts  |  2 +-
 7 files changed, 17 insertions(+), 17 deletions(-)
