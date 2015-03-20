From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Mar 2015 10:07:28 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Defconfig Updates for v4.1
Message-ID: <cover.1426813316.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC defconfig updates for v4.1.


I have been holding off on this for a while as the patches to
enable multiplatform builds for the bockw and ape6evm boards only
really make sense with the following two pull requests applied.
Please consider those pull requests first.

* Renesas ARM Based SoC r8a73a4 CCF and Multiplatform Updates for v4.1
* Renesas ARM Based SoC sh73a0 Multiplatform Updates for v4.1


The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig-for-v4.1

for you to fetch changes up to bb3ab878a29a3879669bb922bebce87b9a9af755:

  ARM: shmobile: Enable bockw board in multiplatform defconfig (2015-03-05 09:20:26 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Defconfig Updates for v4.1

Multiplatform defconfig updates
* Enable bockw and ape6evm boards
* Drop useless SERIAL_8250_EXTENDED=y
* Enable R-Mobile reset

----------------------------------------------------------------
Geert Uytterhoeven (4):
      ARM: shmobile: Enable ape6evm board in multiplatform defconfig
      ARM: shmobile: Enable R-Mobile reset driver in multiplatform defconfig
      ARM: shmobile: defconfig: Drop useless SERIAL_8250_EXTENDED=y
      ARM: shmobile: Enable bockw board in multiplatform defconfig

 arch/arm/configs/shmobile_defconfig | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)
