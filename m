From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Oct 2013 11:39:15 +0900
Subject: [GIT PULL 0/3] Renesas ARM-based SoC DT updates for v3.13
Message-ID: <cover.1380530263.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin, Olof and Arnd,

please consider these Renesas ARM-based SoC DT updates for v3.13.

This pull-request is based on v3.12-rc1.


The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:

  Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v3.13

for you to fetch changes up to 3da4c3039907b655e1758835d57b914a73ff7f5a:

  ARM: shmobile: Add r8a7790 CA7 CPU cores to DTSI (2013-09-19 14:37:35 -0700)

----------------------------------------------------------------
Renesas ARM-based SoC DT updates for v3.13

* Add CPU cores to DTSI of r8a7790 SoC
* Add MMCIF and SDHI DT nodes for reference DTS of ape6evm board

----------------------------------------------------------------
Guennadi Liakhovetski (1):
      ARM: shmobile: ape6evm-reference: add MMCIF and SDHI DT nodes

Magnus Damm (2):
      ARM: shmobile: Add r8a7790 CA15 CPU cores
      ARM: shmobile: Add r8a7790 CA7 CPU cores to DTSI

 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts | 72 +++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7790.dtsi                  | 49 +++++++++++++++++
 2 files changed, 121 insertions(+)
