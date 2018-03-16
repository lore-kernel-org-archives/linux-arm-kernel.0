From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:52:02 +0100
Subject: [GIT PULL] Renesas ARM Based SoC DT Bindings Updates for v4.17
Message-ID: <cover.1521206902.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT bindings updates for v4.17.


The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-bindings-for-v4.17

for you to fetch changes up to 09bea76aad76058d7d1dae8f5804751a017967c1:

  dt-bindings: arm: Document Renesas R-Car M3-N-based Salvator-X board (2018-02-28 07:51:32 +0100)

----------------------------------------------------------------
Renesas ARM Based SoC DT Bindings Updates for v4.17

* Document the bindings for:
  - R-Car V3H (r8a77980) SoC
  - Condor board with V3H (r8a77980) SoC
  - Stout (ADAS Starterkit) board with R-Car H2 (r8a7790) SoC
  - R-Car M3-N (r8a77965) SoC
  - Salvator-X and Salvator-XS boards with R-Car M3-N (r8a77965) SoC
* Document that Armadillo-800 is compatibie with R-Mobile A1 (r8a7740) SoC
* Document part numbers of Wheat and V3MSK boards

----------------------------------------------------------------
Geert Uytterhoeven (4):
      dt-bindings: arm: Document SoC compatible value for Armadillo-800 EVA
      dt-bindings: arm: Document Renesas V3MSK and Wheat board part numbers
      dt-bindings: arm: Document Renesas R-Car M3-N-based Salvator-XS board
      dt-bindings: arm: Document Renesas R-Car M3-N-based Salvator-X board

Jacopo Mondi (1):
      dt-bindings: arm: Document R-Car M3-N SoC DT bindings

Marek Vasut (1):
      dt-bindings: arm: Document Renesas H2-based Stout DT bindings

Sergei Shtylyov (2):
      dt-bindings: arm: document R8A77980 SoC bindings
      dt-bindings: arm: document Condor board bindings

 Documentation/devicetree/bindings/arm/shmobile.txt | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)
