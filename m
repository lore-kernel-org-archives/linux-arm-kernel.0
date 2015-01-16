From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Jan 2015 11:34:44 +0900
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC DT Cleanups for v3.20
Message-ID: <cover.1421371490.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider this second round of Renesas ARM based SoC DT cleanups for
v3.20.


The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-cleanups2-for-v3.20

for you to fetch changes up to d2b541c98f5402ebb49ee1c636ef5bc31462b4ca:

  ARM: shmobile: r8a7791: tidyup #sound-dai-cells settings (2015-01-13 11:01:55 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC DT Cleanups for v3.20

* Tidy up #sound-dai-cells settings
* Drop "renesas,rcar_sound" compatible value

----------------------------------------------------------------
Geert Uytterhoeven (2):
      ARM: shmobile: r8a7790 dtsi: Drop "renesas,rcar_sound" compatible value
      ARM: shmobile: r8a7791 dtsi: Drop "renesas,rcar_sound" compatible value

Kuninori Morimoto (2):
      ARM: shmobile: r8a7790: tidyup #sound-dai-cells settings
      ARM: shmobile: r8a7791: tidyup #sound-dai-cells settings

 arch/arm/boot/dts/r8a7790-lager.dts   | 1 +
 arch/arm/boot/dts/r8a7790.dtsi        | 9 +++++++--
 arch/arm/boot/dts/r8a7791-koelsch.dts | 1 +
 arch/arm/boot/dts/r8a7791.dtsi        | 9 +++++++--
 4 files changed, 16 insertions(+), 4 deletions(-)
