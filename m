From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 28 Sep 2018 12:21:17 +0200
Subject: [GIT PULL] Renesas ARM64 Based SoC SoC Updates for v4.20
Message-ID: <cover.1538127537.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM64 based SoC SoC updates for v4.20.


The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-soc-for-v4.20

for you to fetch changes up to 692dce77dfb71b5eaf896d3cdc7ef72f70631b14:

  arm64: Add Renesas R8A774C0 support (2018-09-11 15:50:57 +0200)

----------------------------------------------------------------
Renesas ARM64 Based SoC SoC Updates for v4.20

* Add support for RZ/G2E (r8a774c0) and RZ/G2M (r8a774a1) SoCs
* Enable Compare Match Timer (CMT) and Timer Unit (TMU)
  for Renesas SoCs
* Remove no longer needed ARCH_SHMOBILE Kconfig symbol

----------------------------------------------------------------
Biju Das (1):
      arm64: Add Renesas R8A774A1 support

Fabrizio Castro (1):
      arm64: Add Renesas R8A774C0 support

Geert Uytterhoeven (1):
      arm64: renesas: Remove the ARCH_SHMOBILE Kconfig symbol

Sergei Shtylyov (1):
      arm64: enable CMT/TMU support for Renesas SoC

 arch/arm64/Kconfig.platforms | 58 ++++++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 24 deletions(-)
