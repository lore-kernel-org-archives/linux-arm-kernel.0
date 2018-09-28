From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 28 Sep 2018 12:23:48 +0200
Subject: [GIT PULL] Renesas ARM Based SoC DT Bindings Updates for v4.20
Message-ID: <cover.1538129305.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT bindings updates for v4.20.


The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-bindings-for-v4.20

for you to fetch changes up to 39c0e5a8746cfbfb87e86761337c807e7faea134:

  dt-bindings: arm: Document RZ/G2E SoC DT bindings (2018-09-12 10:27:16 +0200)

----------------------------------------------------------------
Renesas ARM Based SoC DT Bindings Updates for v4.20

* Document bindings for:
  - RZ/G2E (r8a774c0), RZ/G2M (r8a774a1) and RZ/A2 (r7s9210) SoCs
  - R-Car M3-N (r8a77965) SoC based ULCB board

----------------------------------------------------------------
Biju Das (1):
      dt-bindings: arm: Document RZ/G2M SoC DT bindings

Chris Brandt (1):
      dt-bindings: arm: Document RZ/A2 SoC DT bindings

Eugeniu Rosca (1):
      dt-bindings: arm: Document Renesas R-Car M3-N-based ULCB board

Fabrizio Castro (1):
      dt-bindings: arm: Document RZ/G2E SoC DT bindings

 Documentation/devicetree/bindings/arm/shmobile.txt | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)
