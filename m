From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  6 Dec 2017 11:21:40 +0100
Subject: [GIT PULL] Renesas ARM Based SoC DT Bindings Updates for v4.16
Message-ID: <cover.1512553735.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT bindings updates for v4.16.


The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-bindings-for-v4.16

for you to fetch changes up to eebd0732136fd293c8f15a435978c1c34cd7f32f:

  arm64: renesas: document V3MSK board bindings (2017-11-29 09:18:24 +0100)

----------------------------------------------------------------
Renesas ARM Based SoC DT Bindings Updates for v4.16

* Document V3MSK board bindings

  These are the bindings for the R-Car V3M Starter Kit

* Document M3-W-based Salvator-XS board bingigns

  Geert Uytterhoeven says "The Renesas Salvator-XS (Salvator-X 2nd version)
  development board can be equipped with either an R-Car H3 ES2.0 or M3-W
  ES1.x SiP, which are pin-compatible."

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ARM: shmobile: Document Renesas M3-W-based Salvator-XS board DT bindings

Sergei Shtylyov (1):
      arm64: renesas: document V3MSK board bindings

 Documentation/devicetree/bindings/arm/shmobile.txt | 4 ++++
 1 file changed, 4 insertions(+)
