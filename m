From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 28 Aug 2013 10:40:54 +0900
Subject: [GIT PULL] Third round of Renesas ARM-based SoC DT updates for v3.12
Message-ID: <cover.1377652718.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin, Hi Olof, Hi Arnd,

please consider this third round of Renesas ARM based SoC DT updates for v3.12.

It is based on renesas-dt2-for-v3.12 ("Second round of ARM based SoC DT
updates for v3.12") which you have previously pulled.

I apologise that this and other pull requests that I will send today
are rather later in the cycle than I would like. This is primarily due
to a combination of my summer vacation and wanting to let the patches
sit in next for a while.

The following changes since commit 8b3e32c1fe5dce55e28e76b20361841dc863ec17:

  ARM: shmobile: r8a7740: Add TPU node to the device tree (2013-08-06 18:06:23 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt3-for-v3.12

for you to fetch changes up to ba6094d6e8f30a538e08e9a892f3e37debd84413:

  ARM: shmobile: ape6evm-reference: add MMCIF and SDHI DT nodes (2013-08-22 11:37:53 +0900)

----------------------------------------------------------------
Third round of Renesas ARM-based SoC DT updates for v3.12

* Add MMCIF and SDHI to reference DT nodes of ape6evm board

----------------------------------------------------------------
Guennadi Liakhovetski (1):
      ARM: shmobile: ape6evm-reference: add MMCIF and SDHI DT nodes

 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts | 72 +++++++++++++++++++++++++
 1 file changed, 72 insertions(+)
